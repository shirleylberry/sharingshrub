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
  has_many :charities, through: :events
  has_many :causes, through: :charities
  belongs_to :user

  def self.most_active_hosts(time_period: 0, num_hosts: 10)
    time_period = time_period > 0 ? Time.now - time_period.days : Time.new(1999, 01, 01) 
    Host.select('COUNT(events.id) AS events_thrown, hosts.*').joins(:events).where('events.created_at > ? ', time_period).group('hosts.id').order('events_thrown DESC').limit(num_hosts)
  end

end

