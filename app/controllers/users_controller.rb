get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  erb :'index'
end

get '/users/new/?' do
  @user = User.new

  errors = @user.errors.full_messages
  erb :'users/new', locals: { errors: errors }
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
    redirect "/" unless current_user.id == @user.id

    erb :'users/show'
end
