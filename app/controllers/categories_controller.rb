class CategoriesController < ApplicationController  
  before_filter :authorize
  def index
    @categories = Category.all
  end

  def show
    @categories = Category.find(params[:id])
  end

  def new
    @categories = Category.new
  end

  def create
    @categories = Category.new(params[:category])
    if @categories.save
      flash[:notice] = "Successfully created categories."
      redirect_to @categories
    else
      render :action => 'new'
    end
  end

  def edit
    @categories = Category.find(params[:id])
  end

  def update
    @categories = Category.find(params[:id])
    if @categories.update_attributes(params[:category])
      flash[:notice] = "Successfully updated categories."
      redirect_to categories_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @categories = Category.find(params[:id])
    @categories.destroy
    flash[:notice] = "Successfully destroyed categories."
    redirect_to categories_url
  end
end
