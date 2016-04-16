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
  has_many :causes, through: :events
  belongs_to :user

  delegate :name, :email, to: :user

  def total_pledged
    Pledge.where('donor_id = ?', self.id).sum('amount')
  end

  def pledged_amount(event)
    Pledge.select(:amount).where('donor_id = ? AND event_id = ? ', self, event)
  end 

  def pledges_by_cause(cause)
    Pledge.select(:amount).joins(:causes).where('cause_id = ? AND donor_id = ?', cause, donor)
  end

  def self.top_supports_in_array(cause)
    where(cause: cause).order
  end

  def average_donated
  end

  def favorite_charity
  end

  def favorite_cause
    Pledge.select('causes.id AS id, causes.name').joins(:donor, :event => {:charities => :causes}).where('donors.id = ?', self.id).group('causes.name').order('COUNT(pledges.id) DESC').limit(1)
  end

  # by frequency of donating
  # do it frequency in the last few (3?) months
  def self.top_donors(time_period)
  end

end
