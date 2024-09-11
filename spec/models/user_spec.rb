require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_tweets).through(:likes).source(:tweet) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_tweets).through(:bookmarks).source(:tweet) }
  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeted_tweets).through(:retweets).source(:tweet) }
  it { should have_many(:views) }
  it { should have_many(:viewed_tweets).through(:views).source(:tweet) }
  it { should have_many(:retweeted_tweets).through(:retweets).source(:tweet) }

  it { should have_many(:who_i_follow).with_foreign_key(:follower_id).class_name('Followership') }
  it { should have_many(:followees).through(:who_i_follow).dependent(:destroy) }

  it { should have_many(:who_follow_me).with_foreign_key(:followee_id).class_name('Followership') }
  it { should have_many(:followers).through(:who_follow_me).dependent(:destroy) }

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
