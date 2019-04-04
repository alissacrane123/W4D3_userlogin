class SessionsController < ApplicationController
  before_action :require_current_user!, except: [:create, :new]
  def new
    render :new
  end

  def create 
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    
    if user.nil?
      render json: "The username you provided doesn't exist"
    elsif user.is_password?(params[:user][:password])
      login!(user)
      redirect_to cats_url(user)
    else
      render json: "Invalid credentials"
      render :new
    end 
  end 

  def destroy 
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      current_user = nil
      render :new
    else
      render json: "User doesn't exist"
    end 
    # logout!
    # redirect_to new_session_url 
  end 

end
