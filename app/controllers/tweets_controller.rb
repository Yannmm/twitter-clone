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
    tweet = Tweet.find(params[:id])
    @tweet_presenter = TweetPresenter.new(tweet, current_user)
    log_view
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end

  def log_view
    return if View.exists?(tweet: @tweet_presenter.tweet, user: current_user)

    view = current_user.views.build(tweet: @tweet_presenter.tweet)
    view.save!
  rescue ActiveRecord::RecordNotUnique => _e
    # Handle the exception here
  end
end
