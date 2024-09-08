class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    result = params.require(:user).permit(
      :username,
      :display_name,
      :email,
      :password,
      :bio,
      :location,
      :url
    )
    result.delete(:password) unless result[:password].present?
    result
  end
end
