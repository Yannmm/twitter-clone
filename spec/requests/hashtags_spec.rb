require 'rails_helper'

RSpec.describe 'Hashtags', type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'GET /index' do
    it "succeeds" do
      get hashtags_path
      expect(response).to have_http_status(:success)
    end
  end

end