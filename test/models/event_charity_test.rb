# == Schema Information
#
# Table name: event_charities
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  charity_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class EventCharityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
