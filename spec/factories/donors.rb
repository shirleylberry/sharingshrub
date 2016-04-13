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

    factory :donor_with_posts do
      transient do
        pledges_count 5
      end

      after(:create) do |donor, evaluator|
        create_list(:pledge, evaluator.posts_count, donor: donor)
      end
    end
  end


end
