require 'rails_helper'

RSpec.describe Followership, type: :model do
  it { should belong_to :user }
  it { should belong_to :following_user }
end
