class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @users = User.find(params[:id])
  end

  def new
    @users = User.new
  end

  def create
    @users = User.new(params[:user])
    if @users.save
      flash[:notice] = "Successfully created users."
      redirect_to @users
    else
      render :action => 'new'
    end
  end

  def edit
    @users = User.find(params[:id])
  end

  def update
    @users = User.find(params[:id])
    if @users.update_attributes(params[:user])
      flash[:notice] = "Successfully updated users."
      redirect_to users_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @users = User.find(params[:id])
    @users.destroy
    flash[:notice] = "Successfully destroyed users."
    redirect_to users_url
  end

end
