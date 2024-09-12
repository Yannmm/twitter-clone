class FollowershipsController < ApplicationController
  def create
    followership = current_user.who_i_follow.build(followee_id: params[:user_id])
    if followership.save
      respond_to do |format|
        format.html do
          redirect_to user_path(params[:user_id]), notice: 'User followed successfully.'
        end
      end
    else
      redirect_to user_path(params[:user_id]), alert: 'Failed to follow user.'
    end
  end

  def destroy
    followership = Followership.find(params[:id])

    if followership.destroy
      respond_to do |format|
        format.html do
          redirect_to user_path(params[:user_id]), notice: 'User unfollowed successfully.'
        end
      end
    else
      redirect_to user_path(params[:user_id]), alert: 'Failed to unfollow user.'
    end
    # redirect_to user_path(params[:user_id]), alert: 'Failed to unfollow user.'
  end

  private

  def followership_params
  end
end
