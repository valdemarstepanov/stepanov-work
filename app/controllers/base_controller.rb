class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  include Pundit::Authorization
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    redirect_to root_path, alert: t('controllers.application_controller.user_not_authorized.flash.alert')
  end

end
