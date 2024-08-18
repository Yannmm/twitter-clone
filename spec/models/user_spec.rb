require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank }

  describe '#set_display_name' do
    context 'when display_name is set.' do
      it 'does not change display_name.' do
        user = build(:user, username: 'good@123', display_name: 'John Doe')
        user.save
        expect { user.save! }.not_to change(user, :display_name)
      end
    end

    context 'when display_name is not set.' do
      it 'humanizes the previously set username' do
        user = build(:user, username: 'ryan', display_name: nil)
        expect { user.save! }.to change(user, :display_name).from(nil).to('Ryan')
      end
    end
  end
end
