class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      respond_to do |format|
        format.html do
          redirect_to profile_path, notice: 'Profile updated successfully.'
        end
        format.turbo_stream
      end

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
      :website
    )
    result.delete(:password) unless result[:password].present?
    result
  end
end
