class HomesController < ApplicationController

  def index
    @report = Report.approved
  end

end
