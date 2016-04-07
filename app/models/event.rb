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

class Event < ActiveRecord::Base
  belongs_to :host
  has_many :event_charities
  has_many :charities, through: :event_charities
  has_many :pledges
  has_many :donors, through: :pledges
end
