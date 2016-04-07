# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  host_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_start :datetime
#  event_end   :datetime
#  funded      :boolean
#  goal        :float
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
