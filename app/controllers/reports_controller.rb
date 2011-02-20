# encoding: utf-8
class ReportsController < ApplicationController

  before_filter :authorize, :except => [:index, :new, :show, :create, :destroy, :vote_up]


  def index
    @reports = Report.order("created_at desc").paginate(:per_page => 4, :page => params[:page])
    #@comments = Comment.find(:all, :order => 'comments.created_at DESC', :limit=> 5)
  end

  def show
    @reports = Report.find(params[:id])
  end

  def new
    @reports = Report.new
    3.times { @reports.assets.build }
    unless current_user
      @reports.user = User.new
    end
    respond_to do |format|
      format.html # index.html.erb
      format.js
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
    3.times { @reports.assets.build }
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

  def vote_up
    @reports = Report.find(params[:id])
    if user_signed_in?
      unless current_user.voted_for?(@reports)
        if current_user.vote_for(@reports)
          respond_to do |format|
            format.html
            format.js { redirect_to :action => 'show' }
          end
        end
      end
    else
      respond_to do |format|
        format.html
        format.js { redirect_to :action => 'show' }
      end
    end
  end

end
