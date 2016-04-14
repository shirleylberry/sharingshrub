# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  admin                  :boolean          default("f")
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :host
  has_one :donor
  has_many :events, through: :host
  has_many :pledges, through: :donor 

  def is_host(event)
    self.id == event.host.user.id
  end

  def is_donor(event)
    event.donors.include?(self.donor)
  end

  def events_to_checkout
    if self.donor
      favorite_cause = self.donor.favorite_cause[0]
      Event.select('events.id AS id, events.title, SUM(pledges.amount) AS raised').joins(:pledges, :charities => :causes).where('causes.id = ?', favorite_cause.id).group('events.id').order('raised DESC').limit(10)
    else
      Event.upcoming_events(limit: 5)
    end
  end

  def username
    self.email.split('@')[0]
  end

end
