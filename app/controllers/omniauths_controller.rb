class OmniauthsController < ApplicationController
  
  def create
    auth = request.env['omniauth.auth']
    user = User.create_from_omniauth(auth)
    if user
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect user, :event => :authentication
    else
      flash[:notice] = "Login failed."
      redirect_to new_user_registration_url
    end
  end
end
