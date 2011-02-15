# encoding: utf-8
class ReportsController < ApplicationController

  before_filter :authorize, :except => [:index, :new, :show, :create, :destroy]


  def index
    @reports = Report.order("created_at desc").paginate(:per_page => 4, :page => params[:page])
  end

  def show
    @reports = Report.find(params[:id])
  end

  def new
    @reports = Report.new
    unless current_user
      @reports.user = User.new
    end
  end

  def create
    @reports = Report.new(params[:report])
    if current_user
      @reports.user_id = current_user.id
    end
    if @reports.save
      flash[:notice] = t('general.created')
      redirect_to @reports
    else
      if (@reports.errors['user.email'] == ["Такой email уже существует"] || @reports.errors['user.email'] == ["has already been taken"]) && (@reports.errors.count <= 1)
        @reports.save(:validate => false)
        flash[:notice] = t('general.created')
        redirect_to @reports
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @reports = Report.find(params[:id])
  end

  def update
    @reports = Report.find(params[:id])
    if @reports.update_attributes(params[:report])
      flash[:notice] = t('general.updated')
      redirect_to reports_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @reports = Report.find(params[:id])
    @reports.destroy
    flash[:notice] = t('general.destroyed')
    redirect_to reports_url
  end


end
