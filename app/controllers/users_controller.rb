class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/home'
    end
  end

  post '/signup' do
    downcase_name = params[:username].downcase
    downcase_email = params[:email].downcase
    username_taken = User.find_by(:username => downcase_name)
    email_taken = User.find_by(:email => downcase_email)
    if username_taken
        @error_message = "Sorry, that username is already taken."
        erb :'/users/error_message'
    elsif email_taken
        @error_message = "Sorry, that email is already taken."
        erb :'/users/error_message'
    elsif !valid_login?(params[:username])
        @error_message = "Sorry, special characters are not allowed in username. Choose only words, underscore and numbers. Please try again."
        erb :'/users/error_message'
    elsif params[:username] == "" || params[:email] == "" || params[:password] == ""
        @error_message = "Sorry, all fields must be filled out. Try again."
        erb :'/users/error_message'
    else
      @user = User.new(:username => downcase_name, :email => downcase_email, :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/home'
    end
  end


  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/home'
    end
  end

  post '/login' do
    downcase_name = params[:username].downcase
    user = User.find_by(:username => downcase_name)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/home"
    else
      @error_message = "Sorry, the username or password did not match our system."
      erb :"users/error_message"
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/'
    end
  end

  get '/user/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      if @user
          erb :'users/show_individual_user'
      else
          erb :'/users/dontexist'
      end
    else
      redirect to '/'
    end
  end

  get '/noresult' do
    if logged_in?
      erb :'notes/no_result'
    else
      redirect to '/'
    end
  end

  get '/users' do
    if logged_in?
      @all_users = User.all
      erb :'users/show_all_users'
    else 
      redirect to '/'
    end
  end

  get '/user/:username/edit' do
     
    if logged_in? && (params[:username].downcase == current_user.username.downcase)
      @user = User.find_by_id(current_user.id)
      erb :'users/edit_user'
    else
      "Sorry, you are not allowed to edit other people's profile."
    end
  end

  patch '/saved' do
    if logged_in?
      @user = User.find_by_id(current_user.id)
      @user.update(bio: params[:bio])
      erb :"users/show_individual_user"
    else
      redirect to '/login'
    end
  end


end 