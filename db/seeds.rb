# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


20.times do
  User.create(name: Faker::Name.name)
  Cause.create(name: Faker::Lorem.sentence)
end 

i=0
10.times do 
  Host.create(user: User.all[i])
  Donor.create(user: User.all[i+10])
  i+=1
end

 Charity.create(name: "Direct Relief") 
 Charity.create(name: "MAP International")  
 Charity.create(name: "Samaritan's Purse")  
 Charity.create(name: "Catholic Medical Mission Board")
 Charity.create(name: "AmeriCares")  
 Charity.create(name: "The Rotary Foundation of Rotary International") 
 Charity.create(name: "The Conservation Fund") 
 Charity.create(name: "United States Fund for UNICEF") 
 Charity.create(name: "Natural Resources Defense Council") 
 Charity.create(name: "Doctors Without Borders, USA")

 5.times do 
   i= rand(1..12) 
   j= rand(1..30)
   k= rand(13..24)
   event = Event.create(title: Faker::Lorem.words,event_start: Time.new(2016, i, j, i), 
    event_end: Time.new(2016, i, j, k), host_id: Host.all.sample,
    funded: false, goal: rand(10..1000))  
   EventCharity.create(event_id: event.id, charity_id: Charity.all.sample) 
 end 

30.times do 
  Pledge.create(event: Event.all.sample, donor: Donor.all.sample, amount: rand(5..100), status: "pending")
end 


10.times do 
CauseCharity.create(cause: Cause.all.sample , charity_id: Charity.all.sample)
end 


