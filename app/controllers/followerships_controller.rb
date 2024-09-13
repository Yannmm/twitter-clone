class FollowershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: %i[create destroy]

  def create
    @followership = current_user.who_i_follow.build(followee_id: params[:user_id])
    if @followership.save
      respond_to do |format|
        format.html do
          redirect_to user_path(params[:user_id]), notice: 'User followed successfully.'
        end
        format.turbo_stream
      end
    else
      redirect_to user_path(params[:user_id]), alert: 'Failed to follow user.'
    end
  end

  def destroy
    @followership = Followership.find(params[:id])

    if @followership.destroy
      respond_to do |format|
        format.html do
          redirect_to user_path(params[:user_id]), notice: 'User unfollowed successfully.'
        end
        format.turbo_stream
      end
    else
      redirect_to user_path(params[:user_id]), alert: 'Failed to unfollow user.'
    end
  end

  def user
    @user = User.find(params[:user_id])
  end
end
