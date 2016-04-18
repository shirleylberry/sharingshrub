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
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_one :host
  has_one :donor
  has_many :events, through: :host
  has_many :pledges, through: :donor 

  def is_host(event)
    self.id == event.host.user.id
  end

  def username
    self.name ? self.name.split(' ')[0] : self.email.split('@')[0]
  end

  def events_to_checkout
    if self.donor
      favorite_cause = self.donor.favorite_cause[0]
      Event.select('events.id AS id, events.title, SUM(pledges.amount) AS raised').joins(:pledges, :charities => :causes).where('causes.id = ?', favorite_cause.id).group('events.id').order('raised DESC').limit(5)
    else
      Event.upcoming_events(limit: 5)
    end
  end




end
