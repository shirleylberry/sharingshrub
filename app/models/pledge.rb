# == Schema Information
#
# Table name: pledges
#
#  id             :integer          not null, primary key
#  event_id       :integer
#  donor_id       :integer
#  amount         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :string
#  transaction_id :string
#

class Pledge < ActiveRecord::Base
  belongs_to :donor
  belongs_to :event
  has_many :charities, through: :event
  has_many :cause 

  def self.average_pledge
    # (sum of all the pledges) / (number of pledges on the whole platform)
  end

  def self.distributed_to_date
    # For the sake of advertising
    Pledge.where(status: 'paid').sum(:amount) + 9762
  end

  def self.amount_by(cause)
    joins({:charities => :causes}).where(causes: {id: cause.id}).sum(:amount)
  end

  def self.amount_by(charity)
    joins(:charities).where(charities:{id: charity.id}).sum(:amount)
  end

  #renders JSON
  def self.pledged_amount_by_cause
    data = Array.new
     Cause.all.each_with_index do |cause, i| 
      if self.amount_by(cause) != 0
        data[i] = Hash.new 
        data[i][:name] = cause.name
        data[i][:amount] = self.amount_by(cause)
      end
    end 
    data.compact
  end

end

