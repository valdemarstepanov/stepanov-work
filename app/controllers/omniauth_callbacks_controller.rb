class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def google_oauth2
  
    auth ||= request.env['omniauth.auth']

    user = User.find_by(email: auth.info.email)
   
    if user.present?
      sign_out_all_scopes
      flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end
end
