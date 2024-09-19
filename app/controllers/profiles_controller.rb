class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update]

  def show
  end

  def update
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

  def set_user
    @user = current_user
    @tweet_presenters = @user.tweets.map do |tweet|
      TweetPresenter.new(tweet, current_user)
    end
  end

  def user_params
    result = params.require(:user).permit(
      :username,
      :display_name,
      :email,
      :password,
      :bio,
      :location,
      :website,
      :avatar
    )
    result.delete(:password) unless result[:password].present?
    result
  end
end
