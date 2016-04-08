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
  include MultiparameterDateTime

  multiparameter_date_time :event_start
  multiparameter_date_time :event_end
  
  belongs_to :host
  has_many :event_charities
  has_many :charities, through: :event_charities
  has_many :pledges
  has_many :donors, through: :pledges

  validates :host, presence: true
  validates :charities, length: {in: 1..3}

  validate :start_time_before_end_time

  def start_time_before_end_time
    if self.event_start >= self.event_end
      self.errors.add(:event_start, "must be before event end")
    end
  end
end
