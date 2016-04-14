get '/' do
  @user = User.new
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  puts session[:user_id]
  errors = @user.errors.full_messages
  erb :'index', locals: { errors: errors}
end

get '/users/new/?' do
  @user = User.new
end

post '/users/?' do
  @user = User.new(params[:user])

  if @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    #@user
    errors = @user.errors.full_messages

    erb :'users/new', locals: { errors: errors }
  end
end

get '/users/:id/?' do
    @user = User.find(params[:id])
    @destination = Destination.find_by(user_id: @user.id)
    redirect "/" unless current_user.id == @user.id

    erb :'users/show', locals: {user: @user, destination: @destination}
end
