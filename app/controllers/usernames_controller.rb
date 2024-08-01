class UsernamesController < ApplicationController
  before_action :authenticate_user!

  skip_before_action :redirect_to_username_form

  def edit
  end

  def update
    if username_params[:username].present? && current_user.update(username_params)
      redirect_to dashboard_path, notice: 'Change username successfully.'
    else
      flash.now[:alert] = if username_params[:username].blank?
                            'Please set a username.'
                          else
                            current_user.errors.full_messages.join('; ')
                          end

      render :edit, status: :unprocessable_entity
    end
  end

  def username_params
    params.require(:user).permit(:username)
  end
end
