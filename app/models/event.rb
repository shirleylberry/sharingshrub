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

class Event < ActiveRecord::Base
  belongs_to :host
  has_many :event_charities
  has_many :charities, through: :event_charities
  has_many :pledges
  has_many :donors, through: :pledges
end
