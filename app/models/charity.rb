# == Schema Information
#
# Table name: charities
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Charity < ActiveRecord::Base
  has_many :cause_charities
  has_many :causes, through: :cause_charities
  has_many :event_charities
  has_many :events, through: :event_charities
end
