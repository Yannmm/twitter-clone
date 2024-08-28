class TweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = current_user.tweets.build(tweet_params)

    @tweet_presenter = TweetPresenter.new(tweet, current_user)

    if tweet.save
      respond_to do |format|
        format.html do
          redirect_to dashboard_path, notice: 'Tweet created successfully'
        end
        format.turbo_stream
      end
    else
      flash.now[:error] = 'Could not save client'
      render 'home/index', status: :unprocessable_entity
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    render 'show'
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
