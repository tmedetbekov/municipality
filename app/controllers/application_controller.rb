class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_i18n_locale_from_params

  helper_method :admin?
  helper_method :solved_not?

  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
            "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    {:locale => I18n.locale}
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

