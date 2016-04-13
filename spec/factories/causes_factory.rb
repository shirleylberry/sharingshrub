# == Schema Information
#
# Table name: causes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :cause do
    name "Global Hunger"
  end
end
