# == Schema Information
#
# Table name: charities
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rating     :string
#  mission    :string
#  website    :string
#  address    :string
#

class Charity < ActiveRecord::Base
  has_many :cause_charities
  has_many :causes, through: :cause_charities
  has_many :event_charities
  has_many :events, through: :event_charities
  has_many :hosts, through: :events

  def total_pledges
    Pledge.joins(:charities).where('charities.id = ?', self).sum(:amount)
  end

  def upcoming_events 
    self.events.upcoming_events(limit: 25)
  end
  # revenue that they'll have if their events are funded
  # and the pledge hasn't been paid through yet
  # (i.e. there might be a delay between event passing and 
  # payment being processed)
  def pledge_receivables  
  end

  def amt_paid_out
  end

  # does not include pledges not yet paid
  def raised_to_date(date, event)
    event.pledges.joins(:charities).where('charities.id = ? AND pledges.created_at < ?', self, date).sum(:amount)
  end

  def pledges_lost
  end

  def top_supporters
  end

  def self.five_most_pledged_charities
    Charity.select('charities.name, charities.id AS id, COUNT(pledges.id) AS number_of_pledges').joins(:events => :pledges).group('charities.name').order('number_of_pledges DESC').limit(5)
  end

end

