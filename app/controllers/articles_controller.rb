# encoding: utf-8
class ArticlesController < ApplicationController
  def index
    @articles = Article.order("created_at DESC")
  end

  def list
  end

  def show
    begin
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Такой страницы не существует!"
      redirect_to report_url, :notice => "Такой страницы не существует!"
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def about
    @about = Info.find(1)
  end

  def contact
    @contact = Info.find(1)
  end
end
