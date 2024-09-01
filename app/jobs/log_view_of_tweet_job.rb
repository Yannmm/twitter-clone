class LogViewOfTweetJob < ApplicationJob
  queue_as :default

  def perform(tweet:, user:)
    # Do something later
    log(tweet, user)
  end

  private

  def log(tweet, user)
    return if View.exists?(tweet:, user:)

    view = user.views.build(tweet:)
    view.save!
  rescue ActiveRecord::RecordNotUnique => _e
    # Handle the exception here
  end
end
