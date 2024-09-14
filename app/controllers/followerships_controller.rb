class FollowershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: %i[create destroy]

  def create
    @followership = @user.who_follow_me.build(follower: current_user)

    if @followership.save
      @user.reload
      respond_to do |format|
        format.html do
          redirect_to user_path(@user), notice: 'User followed successfully.'
        end
        format.turbo_stream
      end
    else
      redirect_to user_path(@user), alert: 'Failed to follow user.'
    end
  end

  def destroy
    @followership = @user.who_follow_me.find(params[:id])

    if @followership.destroy
      @user.reload
      respond_to do |format|
        format.html do
          redirect_to user_path(@user), notice: 'User unfollowed successfully.'
        end
        format.turbo_stream
      end
    else
      redirect_to user_path(@user), alert: 'Failed to unfollow user.'
    end
  end

  def user
    @user = User.find(params[:user_id])
  end
end
