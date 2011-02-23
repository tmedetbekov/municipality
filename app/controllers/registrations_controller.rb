# encoding: utf-8
class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    if @user.new_record?
      render_with_scope :new
    end
  end

  def create
    build_resource
    if resource.save
      set_flash_message :notice, :signed_up
      sign_in_and_redirect(resource_name, resource)
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end

  def update
    if resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      if @user.valid?
        session[:omniauth] = nil
      else
        if (@user.errors[:email] == ["has already been taken"] || @user.errors[:email] == ["Такой email уже существует"]) && @user.errors.count <= 1
          user = any_users(@user.email)
          if user
            flash[:notice] = "You have already have an account!"
            @user = user
            @user.authentications.create!(:provider => session[:omniauth]['provider'], :uid => session[:omniauth]["uid"])
            session[:omniauth] = nil
            sign_in(@user)
            redirect_to root_url
          else
            session[:omniauth] = nil
            @user.save(:validate => false)
          end
        elsif (@user.errors[:email] == ["Cannot be blank", "is invalid"] || @user.errors[:email] == ["Это поле не может быть пустым", "Неправильный формат email"]) && @user.errors.count <= 2
          @user.save(:validate => false)
          session[:omniauth] = nil
          flash[:notice] = "You have been registered, please provide your email in order to complete your registration!"
          sign_in(@user)
          redirect_to edit_user_registration_path(@user)
        else
          session[:omniauth] = nil
        end
      end
    end
  end

  def any_users(email)
    user = User.where(:email => email) - User.where(:email => email, :is_anonym => true)
    if(user.count > 0)
      user.first
    end
  end
end
