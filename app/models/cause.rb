# == Schema Information
#
# Table name: causes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cause < ActiveRecord::Base
  has_many :cause_charities
  has_many :charities, through: :cause_charities
  has_many :events, through: :charities 
  has_many :hosts, through: :events
  has_many :pledges, through: :events
  has_many :donors, through: :pledges


  def upcoming_events
    self.events.where("events.event_start > ?", Time.now)
  end

  def top_supporters
    Donor.select('donors.id AS id, SUM(pledges.amount) AS pledged').joins(:pledges => {:charities => :causes}).where('causes.id = ?', self.id).group('id').order('pledged DESC').limit(10)
  end

  def top_supporters_in_last_30_days
    Donor.select('donors.id AS id, SUM(pledges.amount) AS pledged').joins(:pledges => {:charities => :causes}).where(['causes.id = ? AND pledges.created_at > ?', self.id, Time.now - 30.days]).group('id').order('pledged DESC').limit(10)
  end

end
