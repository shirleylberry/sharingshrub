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

  
  def events_by(cause_or_charity)
    self.events.list(cause_or_charity)
  end 
   
  def pledge_count_by_cause
    count_hash = Hash.new(0)
    self.causes.each do |cause|
      name = cause.name
      count_hash[name] += 1
    end
# {"human right": 2 } => [{name: "human right", count: 2}]
# D3 requires Json format
  count_array = count_hash.to_a 
    data_format = count_array.map do |cause| 
      cause[0] = [:name, cause[0]]
      cause[1] = [:count, cause[1]]
      cause.to_h
    end 
    data_format
  end
 
  def pledged_amount_by_cause
    data = Array.new
     Cause.all.each_with_index do |cause, i| 
      data[i] = Hash.new 
      data[i][:name] = cause.name
      data[i][:amount] = self.events_by(cause).sum(:amount)
    end
    data
  end

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
    Pledge.where(donor: donor).average('amount').round
  end

  def supported_charity
    Charity.joins(:events => :donors).where('donor_id =?', self.id).uniq 
  end

  def favorite_cause
    Pledge.select('causes.id AS id, causes.name').joins(:donor, :event => {:charities => :causes}).where('donors.id = ?', self.id).group('causes.name').order('COUNT(pledges.id) DESC').limit(1)
  end

  # by frequency of donating
  # do it frequency in the last few (3?) months
  def self.top_donors(time_period)
  end

end
