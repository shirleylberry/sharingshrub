# == Schema Information
#
# Table name: donors
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Donor < ActiveRecord::Base
  has_many :pledges
  has_many :events, through: :pledges
  belongs_to :user

  def total_pledged
    Pledge.where('donor_id = ?', self.id).sum('amount')
  end

  def pledged_events
    Event.joins(:pledges).where('pledges.donor_id = ?', self.id)
  end

  def pledges_by_cause(cause)

  end

  def average_donated
  end

  def favorite_charity
  end

  # by frequency of donating
  # do it frequency in the last few (3?) months
  def self.top_donors(time_period)
  end

end
