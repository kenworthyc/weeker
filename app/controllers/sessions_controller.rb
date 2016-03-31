#return an HTML form for creating a new session
get '/sessions/new?' do
  erb :'sessions/new'
end

#create a new session
post '/sessions/?' do
  @user = User.find_by(email: params[:email])
  if @user && User.authenticate(params[:email], params[:password_plaintext])
    session[:user_id] = @user.id
    redirect to "/users/#{session[:user_id]}"
  else
    @error = "Sorry, the credentials provided do not match!"
    erb :'sessions/new'
  end  
end

#delete a specific session
delete '/sessions/:id/?' do
  session.delete(:user_id)
  redirect to '/'
end
