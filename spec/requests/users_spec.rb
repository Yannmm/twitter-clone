require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before { sign_in user1 }

  describe 'GET /show' do
    it 'succeeds' do
      get user_path(user2)
      expect(response).to have_http_status(200)
    end
    it 'redirects to profile' do
      get user_path(user1)
      expect(response).to redirect_to(profile_path)
    end
  end
end
