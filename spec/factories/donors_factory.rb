# == Schema Information
#
# Table name: donors
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :donor do
    user
    trait :with_pledges do

      after(:build) do |donor, evaluator|
        create_list(:pledge, 3, donor: donor, amount: 25)
        create_list(:pledge, 2, donor: donor, amount: 15)
      end
    end
  end
end
