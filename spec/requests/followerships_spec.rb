require 'rails_helper'

RSpec.describe 'Followerships', type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before { sign_in user1 }

  describe 'POST /create' do
    it 'creates a new followership' do
      expect do
        post user_followerships_path(user2)
      end.to change { Followership.count }.by(1)
      expect(response).to redirect_to(user_path(user2))
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes an existing followership' do
      followership = create(:followership, follower: user1, followee: user2)
      expect do
        delete user_followership_path(user2, followership)
      end.to change { Followership.count }.by(-1)
      expect(response).to redirect_to(user_path(user2))
    end
  end
end
