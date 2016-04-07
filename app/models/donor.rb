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
end
