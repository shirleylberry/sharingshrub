# == Schema Information
#
# Table name: causes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cause < ActiveRecord::Base
  has_many :cause_charities
  has_many :charities, through: :cause_charities
end
