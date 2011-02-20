class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  helper_method :admin?
  helper_method :solved_not?

  protected
  # Set the locale from parameters
  def set_locale
    I18n.locale = params[:locale] unless params[:locale].blank?
  end

  protected
  def admin?
    current_user.is_admin if current_user
  end

  def authorize
    unless admin?
      flash[:error] = "You don't have enough permissions to access this page"
      redirect_to reports_path
      false
    end
  end


end

