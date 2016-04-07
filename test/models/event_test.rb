# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  title            :string
#  event_start_date :date
#  event_end_date   :date
#  event_start_time :time
#  event_end_time   :time
#  host_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
