class RetweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    retweet = current_user.retweets.build(tweet_id: params[:tweet_id])
    if retweet.save
      @tweet_presenter = TweetPresenter.new(retweet.tweet, current_user)
      respond_to do |format|
        format.html do
          redirect_to dashboard_path, notice: 'Retweeted successfully'
        end
        format.turbo_stream
      end
    else
      redirect_to dashboard_path, alert: 'You cannot retweet this tweet.'
    end
  end

  def destroy
    retweet = current_user.retweets.find(params[:id])
    if retweet.destroy
      @tweet_presenter = TweetPresenter.new(retweet.tweet, current_user)
      respond_to do |format|
        format.html do
          redirect_to dashboard_path, notice: 'Undo retweet successfully'
        end
        format.turbo_stream
      end
    else
      redirect_to dashboard_path, alert: 'You cannot undoe retweet this tweet.'
    end
  end
end
