# encoding: utf-8
# encoding: utf-8
class ReportsController < ApplicationController

    #uses_tiny_mce :options => {
     # :theme => 'advanced',
      #:theme_advanced_resizing => true,
      #:theme_advanced_toolbar_location => "top",
      #:theme_advanced_toolbar_align => "left",
      #:theme_advanced_resize_horizontal => false,
      #:theme_advanced_buttons1 => %w{formatselect bold italic underline strikethrough separator justifyleft justifycenter justifyright indent separator bullist numlist separator forecolor backcolor separator link unlink separator undo redo},
      #:theme_advanced_buttons2 => [],
      #:theme_advanced_buttons3 => [],
      #:width => 200,
      #:theme_advanced_disable => "help,cleanup,charmap,sub,sup,visualaid,anchor,image,code",
      #:plugins => %w{ table fullscreen }
    #}

  before_filter :authorize, :except => [:index, :new, :show, :create, :destroy, :vote_up]

  def index
    @article = Article
    sleep 2
    @reports = Report.approved.order("created_at desc").paginate(:per_page => 5, :page => params[:page])
    #@comments = Comment.find(:all, :order => 'comments.created_at DESC', :limit=> 5)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    begin
      @reports = Report.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Такой страницы не существует!"
      redirect_to reports_path, :notice => "Такой страницы не существует!"
    else
      respond_to do |format|
        format.html
      end
    end

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
