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

end
