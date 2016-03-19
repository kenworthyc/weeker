get '/' do
  erb :'index'
end

get '/users/new/?' do
  @user = User.new
  erb :'users/new'
end

post '/users/?' do
  @user = User.new(params[:user])

  if @user.save
  else
    @user
    errors = @user.errors.full_messages

    erb :'users/new', locals: { errors: errors }
  end
end