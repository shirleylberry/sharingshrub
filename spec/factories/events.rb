# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  title           :string
#  host_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  event_start     :datetime
#  event_end       :datetime
#  funded          :boolean          default("f")
#  goal            :float
#  funded_deadline :datetime
#

FactoryGirl.define do
  factory :event do
    title "Benefit for the Homeless"
    host
    event_start { Time.new(2018, 10, 11, 17) }
    event_end { Time.new(2018, 10, 11, 20) }
    goal 200
    funded_deadline { Time.new(2018, 9, 1, 12) }

    trait :fully_funded do
      after(:build) do |event|
        create_list(:pledge, 5, event: event, amount: 100)
      end
    end

    trait :not_funded do
      after(:build) do |event|
        create_list(:pledge, 2, event: event, amount: 25)
      end
    end
  end
end
