class TweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = current_user.tweets.build(tweet_params)

    if tweet.save
      redirect_to dashboard_path, notice: 'Tweet created successfully'
    else
      flash.now[:error] = 'Could not save client'
      render 'home/index', status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
