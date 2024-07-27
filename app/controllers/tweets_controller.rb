class TweetsController < ApplicationController
  def create
    tweet = current_user.tweets.build(tweet_params)

    if tweet.save
      redirect_to root_path, notice: 'Tweet created successfully'
    else
      flash.now[:error] = 'Could not save client'
      render 'home/index', status: :unprocessable_entity
    end
  end

  def test
    render plain: 'Hello, World!', status: 201
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
