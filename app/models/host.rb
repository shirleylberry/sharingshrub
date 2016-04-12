# == Schema Information
#
# Table name: hosts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Host < ActiveRecord::Base
  has_many :events
  belongs_to :user

  def self.most_active_hosts(time_period)
  end


end
