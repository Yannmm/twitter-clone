class ApplicationController < ActionController::Base
  before_action :redirect_to_username_form, if: -> { user_signed_in? && current_user.username.blank? }

  protected

  def after_sign_in_path_for(_)
    dashboard_path
  end

  def redirect_to_username_form
    redirect_to edit_username_path(current_user)
  end
end
