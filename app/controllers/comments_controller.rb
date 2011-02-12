class CommentsController < ApplicationController
  before_filter do
    @report = Report.find_by_id(params[:report_id])
  end

  def create
    
    @report.comments.create(params[:comment])
    redirect_to @report
  end

  def destroy
    comment = Comment.find_by_id(params[:id])
    comment.destroy
    redirect_to @report
  end

  def edit

  end
end
