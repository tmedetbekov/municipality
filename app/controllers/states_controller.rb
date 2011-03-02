class StatesController < ApplicationController

  before_filter :authorize

  def index
    @states = State.all
  end

  def show
    @states = State.find(params[:id])
  end

  def new
    @states = State.new
  end

  def create
    @states = State.new(params[:state])
    if @states.save
      flash[:notice] = "Successfully created states."
      redirect_to @states
    else
      render :action => 'new'
    end
  end

  def edit
    @states = State.find(params[:id])
  end

  def update
    @states = State.find(params[:id])
    if @states.update_attributes(params[:state])
      flash[:notice] = "Successfully updated states."
      redirect_to states_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @states = State.find(params[:id])
    @states.destroy
    flash[:notice] = "Successfully destroyed states."
    redirect_to states_url
  end
end
