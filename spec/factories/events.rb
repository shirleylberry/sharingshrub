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