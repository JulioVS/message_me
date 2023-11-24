class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create] 

  def new
    # Ya hay una autoinvocacion al chequeo de login para "new" arriba
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
      flash[:error] = "There was something wrong with your login information"
      #render 'new' 
      redirect_to login_path 
    end

    # debugger
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end
  end

end