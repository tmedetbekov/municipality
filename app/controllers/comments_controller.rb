class CommentsController < ApplicationController
  before_filter do
    @report = Report.find_by_id(params[:report_id])
  end

  def create
		if user_signed_in?
			params[:comment][:user_id] = current_user.id
			params[:comment][:author] = current_user.name
			params[:comment][:email] = current_user.email
		end
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
