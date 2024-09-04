class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    like = current_user.likes.build(tweet_id: params[:tweet_id])
    puts "🐶 -> #{params}"
    if like.save
      @source = params[:source]
      @tweet_presenter = TweetPresenter.new(like.tweet, current_user)
      respond_to do |format|
        format.html do
          redirect_to dashboard_path, notice: 'Tweet liked successfully'
        end
        format.turbo_stream
      end
    else
      redirect_to dashboard_path, alert: 'You cannot like this tweet.'
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    if like.destroy
      @source = params[:source]
      @tweet_presenter = TweetPresenter.new(like.tweet, current_user)
      respond_to do |format|
        format.html do
          redirect_to dashboard_path, notice: 'Tweet unliked successfully'
        end
        format.turbo_stream
      end
    else
      redirect_to dashboard_path, alert: 'You cannot unlike this tweet.'
    end
  end
end
