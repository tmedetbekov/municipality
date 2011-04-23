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

RailsAdmin.config do |config|
		config.model Asset do
		  visible false
		end

		config.model Authentication do
		  visible false
		end

		config.model Vote do
		  visible false
		end

		config.model Comment do
		  visible false
		end

		config.model Report do
		  list do
		    field :subject
				field :description
				field :approved
				sort_by :approved
				sort_reverse false
		  end
		end

#		config.model Article do
#		  edit do
#				field :title
#		    field :content, :text do
#		      ckeditor true
#		    end
#		  end
#		end

	end


end
