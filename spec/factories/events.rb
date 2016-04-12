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

# FactoryGirl.define do
#     factory :event do
#         association :charity
#         association :host
#         host factory: :host
#         event_start { Time.new(2016, 10, 11, 17) }
#         event_end { Time.new(2016, 10, 11, 20) }
#         goal { 1000 }
        
#     end
# end
