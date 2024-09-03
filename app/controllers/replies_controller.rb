class RepliesController < ApplicationController
  before_action :authenticate_user!

  def create
    reply = current_user.tweets.build(reply_params.merge({ parent_id: params[:tweet_id] }))
    if reply.save
      @tweet_presenter = TweetPresenter.new(reply, current_user)
      respond_to do |format|
        format.html do
          redirect_to tweet_path(params[:tweet_id]), notice: 'Reply successfully'
        end
        format.turbo_stream
      end
    else
      redirect_to dashboard_path, alert: 'You cannot reply to this tweet.'
    end
  end

  def reply_params
    params.require(:tweet).permit(:body)
  end
end
