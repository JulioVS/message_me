class SessionsController < ApplicationController
  def new

  end

  def create
    input_user = params[:session][:username]
    input_pass = params[:session][:password] 

    user = User.find_by(username: input_user)

    if user && user.authenticate(input_pass)
      session[:user_id] = user.id 
      flash[:success] = "You have succesfully logged in"
      redirect_to root_path 
    else
      flash.now[:error] = "There was something wrong with your login information"
      render 'new' 
    end

    # debugger
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path
  end
end