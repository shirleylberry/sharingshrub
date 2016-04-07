# == Schema Information
#
# Table name: cause_charities
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cause_id   :integer
#  charity_id :integer
#

require 'test_helper'

class CauseCharityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
