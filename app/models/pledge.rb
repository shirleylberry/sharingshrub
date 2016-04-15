# == Schema Information
#
# Table name: pledges
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  donor_id   :integer
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#

class Pledge < ActiveRecord::Base
  belongs_to :donor
  belongs_to :event
  has_many :charities, through: :event

  def self.average_pledge
    # (sum of all the pledges) / (number of pledges on the whole platform)
  end

  def self.distributed_to_date
    # For the sake of advertising
    Pledge.where(status: 'paid').sum(:amount) + 9762
  end

end

