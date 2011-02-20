class HomesController < ApplicationController
  def index
#    @reports = Report.where(:solved => true).limit(5).order("created_at desc")
#    @reports = Report.all
    @reports = Report.where(:solved => true)

  end

end
