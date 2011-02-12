class ContactFormsController < ApplicationController

  def index
    redirect_to root_url
  end

  def new
    @contact_form = ContactForm.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @contact_form = ContactForm.new(params[:contact_form])

    respond_to do |format|
      if @contact_form.deliver
        format.html { redirect_to(@contact_form, :notice => 'Contact form was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
