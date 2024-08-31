require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'GET /show' do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet) }

    before { sign_in user }

    it 'succeeds' do
      get tweet_path(tweet)
      expect(response).to have_http_status(:success)
    end

    it 'increments the view count if the tweet has not been viewed' do
      expect { get tweet_path(tweet) }.to change { View.count }.by(1)
    end

    it 'does not increment the view count if the tweet has been viewed' do
      create(:view, user:, tweet:)
      expect { get tweet_path(tweet) }.not_to(change { View.count })
    end
  end

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
