require 'rails_helper'

RSpec.describe 'Replies', type: :request do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  before { sign_in user }

  describe 'POST /create' do
    it 'creates a new reply' do
      parent = create(:tweet)
      expect do
        post tweet_replies_path(parent, params: {
                                  tweet: {
                                    body: 'New reply body'
                                  }
                                })
      end.to change { Tweet.count }.by(1)
      expect(response).to have_http_status(:redirect)
    end
  end
end
