require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'POST /create' do
    context 'user is not signed in' do
      it 'is redirected' do
        post tweets_path, params: {
          tweet: {
            body: 'New tweet body'
          }
        }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      it 'is redirected ' do
        user = create(:user)
        sign_in user
        expect do
          post tweets_path, params: {
            tweet: {
              body: 'New tweet body'
            }
          }
        end.to change { Tweet.count }.by(1)
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
