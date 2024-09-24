require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it { should belong_to :user }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liking_users).through(:likes).source(:user) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarking_users).through(:bookmarks).source(:user) }
  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeting_users).through(:retweets).source(:user) }
  it { should have_many(:views).dependent(:destroy) }
  it { should have_many(:viewing_users).through(:views).source(:user) }
  it { should belong_to(:user) }
  it { should belong_to(:parent).with_foreign_key(:parent_id).inverse_of(:replies).class_name('Tweet').optional }
  it { should have_many(:replies).with_foreign_key(:parent_id).class_name('Tweet') }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(280) }
  it { should have_and_belong_to_many :hashtags }
end
