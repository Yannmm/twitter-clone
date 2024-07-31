require 'rails_helper'

RSpec.describe 'Usernames', type: :request do
  let(:user) { create(:user, username: nil) }

  before { sign_in user }

  describe 'GET /usernames/new' do
    context 'username is not set yet' do
      it 'is successful' do
        get edit_username_path(user)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PUT /username_path' do
    it 'updates the username then is redirected to dashboard' do
      expect do
        put username_path(user), params: {
          user: {
            username: 'Abc Haha'
          }
        }
      end.to change { user.reload.username }.from(nil).to('Abc Haha')
      expect(response).to redirect_to(dashboard_path)
    end
  end

  # context 'user is signed in' do
  #   it 'is redirected ' do
  #     user = create(:user)
  #     sign_in user
  #     expect do
  #       post tweets_path, params: {
  #         tweet: {
  #           body: 'New tweet body'
  #         }
  #       }
  #     end.to change { Tweet.count }.by(1)
  #     expect(response).to redirect_to(dashboard_path)
  #   end
  # end
end
