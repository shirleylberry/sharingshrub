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

class EventCharity < ActiveRecord::Base
  belongs_to :event
  belongs_to :charity
end
