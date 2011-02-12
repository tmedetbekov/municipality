class SessionsController < ApplicationController
  before_filter :notauthorized_user, :except => [:new, :create]
  before_filter :authorized_user, :except => [:destroy]
  def new
  end

  def create
    user = User.authenticate(params["/sessions"][:email], params["/sessions"][:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    user = User.find(session[:user_id])
    user.ip_address = request.remote_ip
    user.save

    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
