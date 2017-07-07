class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else 
      render :new
    end
  end

  def destroy 
    session[:user_id] = nil
    redirect_to '/'
  end

  def new 
    @user = User.new
  end 

  private 

end