# == Schema Information
#
# Table name: cause_charities
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CauseCharity < ActiveRecord::Base
  belongs_to :cause
  belongs_to :charity
end
