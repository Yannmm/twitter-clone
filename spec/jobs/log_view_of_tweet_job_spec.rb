require 'rails_helper'

RSpec.describe LogViewOfTweetJob, type: :job do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  # subject do
  #   described_class.new.perform_now(tweet, user)
  # end

  it 'creates a new view when the tweet has not been viewed' do
    expect do
      LogViewOfTweetJob.perform_now(tweet:, user:)
    end.to change { View.count }.by(1)
  end

  it 'does not create a new view when the tweet has already been viewed' do
    create(:view, user:, tweet:)
    expect do
      LogViewOfTweetJob.perform_now(tweet:, user:)
    end.not_to(change { View.count })
  end
end
