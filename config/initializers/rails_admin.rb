require "rails_admin/application_controller"

module RailsAdmin
  class ApplicationController < ::ApplicationController
    before_filter :authenticate_admin
        
    private
    def authenticate_admin
      unless current_user.is_admin
        flash[:notice] = "Unauthorized access."
        redirect_to root_url
        false
      end
    end
  end
end
