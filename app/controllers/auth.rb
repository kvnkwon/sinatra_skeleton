# Creating a User
get '/signup' do
  erb :'auth/signup'
end

post '/signup' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect("/")
  else
    session[:error] = user.errors.messages
    redirect("/signup")
  end
end

# Login
get '/login' do
  erb :'auth/login'
end

post '/login' do
  user = User.find_by(name: params[:user][:name]).try(:authenticate, params[:user][:password])
  # Try can be used on a nil object, so it won't lead to the no method error page.
  if user
    session[:user_id] = user.id
    redirect("/")
  else
    set_error("Username not found or password is incorrect.")
    redirect("/login")
  end
end

# Logout
get '/logout' do
  session[:user_id] = nil
  redirect("/")
end
