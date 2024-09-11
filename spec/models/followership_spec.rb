require 'rails_helper'

RSpec.describe Followership, type: :model do
  it { should belong_to :follower }
  it { should belong_to :followee }
end
