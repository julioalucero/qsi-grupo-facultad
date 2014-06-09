class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_or_create_by_facebook_oauth(env["omniauth.auth"], current_user)

    if !!@user and @user.persisted?
      update_access_token
      update_email if @user.sign_in_count == 1
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      set_flash_message(:error, :failure, :kind => "Facebook", :reason => "You should be member of the group") if is_navigational_format?
      redirect_to new_user_registration_url
    end
  end

  def update_access_token
    access_token = env["omniauth.auth"]['credentials']['token']
    @user.update_attribute(:oauth_access_token, access_token)
  end

  def update_email
    email = env["omniauth.auth"]['info']['email']
    @user.update_attribute(:email, email)
  end

end
