class AuthenticationsController < ApplicationController

  def create
   auth = request.env["omniauth.auth"]
   authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth["uid"])
   if authentication
     flash[:notice] = "Signed in successfully"
     sign_in_and_redirect(:user, authentication.user)
   elsif current_user
     current_user.authentications.create!(:provider => auth[:provider], :uid => auth["uid"])
     flash[:notice] = "Authentication successfull"
     redirect_to authentications_url
   else
     user = User.new
     user.apply_omniauth(auth)
     if user.save
       flash[:notice] = "Signed in successfully"
       sign_in_and_redirect(:user,  user)
     else
       if auth["provider"] == "twitter"
         session[:omniauth] = auth.except("extra")
       else
         session[:omniauth] = auth
       end
       redirect_to new_user_registration_url
     end
   end
  end
  
end
