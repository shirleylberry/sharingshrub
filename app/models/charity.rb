# == Schema Information
#
# Table name: charities
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Charity < ActiveRecord::Base
  has_many :cause_charities
  has_many :causes, through: :cause_charities
  has_many :event_charities
  has_many :events, through: :event_charities

  def raised_this_year
  end

  def upcoming_events
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
  def raised_to_date
  end

  def pledges_lost
  end

  def top_supporters
  end

end

