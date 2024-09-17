class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    return redirect_to profile_path if current_user.id == @user.id

    @followership = current_user.who_i_follow.find_by(followee_id: @user.id)

    @tweet_presenters = @user.tweets.map do |tweet|
      TweetPresenter.new(tweet, current_user)
    end

    render 'profiles/show'
  end
end
