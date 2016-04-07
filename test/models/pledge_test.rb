# == Schema Information
#
# Table name: pledges
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  donor_id   :integer
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#

require 'test_helper'

class PledgeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
