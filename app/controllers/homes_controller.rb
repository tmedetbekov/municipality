class HomesController < ApplicationController
  def index
    @reports = Report.all
  end
end
