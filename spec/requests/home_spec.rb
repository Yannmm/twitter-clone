require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /index' do
    context 'user is not signed in' do
      it 'is successful' do
        get root_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'user is signed in' do
      it 'is redirected to dashboard' do
        user = create(:user)
        sign_in user
        get root_path
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
