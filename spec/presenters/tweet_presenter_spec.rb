require 'rails_helper'

RSpec.describe User, type: :presenter do
  let(:current_user) { create(:user) }

  describe '#created_at' do
    context 'when 24 hours have passed' do
      before do
        Timecop.freeze Time.local(2008, 9, 3, 10, 5, 0)
      end
      after do
        Timecop.return
      end
      it 'displays the shortend date format' do
        tweet = create(:tweet)
        tweet.update! created_at: 2.days.ago
        expect(TweetPresenter.new(tweet, :current_user).created_at).to eq('Sep 1')
      end
    end
    context 'before a full day has passed' do
      it 'displays how many hours have passed' do
        tweet = create(:tweet)
        tweet.update! created_at: 2.hours.ago
        expect(TweetPresenter.new(tweet, :current_user).created_at).to eq('about 2 hours')
      end
    end
  end
  before do
    Timecop.freeze(Time.local(1990))
  end
end
