# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# clears the database before seeding
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  # MySQL and PostgreSQL
  # ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
  # SQLite
  ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
end

cause = ["Education", "Environment", "Public Health", "Human and Civil Rights", "Religion", "Wildlife Conservation", "Homeless Service", "Animal Rights"]
cause.each do |type|
  Cause.create(name: type)
end 

charities = ["Direct Relief", "MAP International", "Samaritan's Purse", "Catholic Medical Mission Board", "AmeriCare", "The Conservation Fund", "United States Fund for UNICEF", "Natural Resources Defense Council", "Doctors Without Borders, USA" ]
charities.each do |charity| 
  Charity.create(name: charity)
end 

1000.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.safe_email, password: Faker::Internet.password)
end 

i=0
100.times do 
  Host.create(user: User.all[i]) 
  j=0
  5.times do
  Donor.create(user: User.all[i+j])
  j+=1
  end 
  i+=5
end
#Donor should belong to one user


100.times do 
  i = rand(1..12) 
  j = rand(1..30)
  k = rand(10..100)
  start_time = Time.new(2016, i, j, i)
  event = Event.new(title: Faker::Book.title,
                    event_start: start_time,
                    event_end: start_time + i.days,
                    host: Host.all.sample,
                    funded: false,
                    address: '#{rand(10..1000)} Broadway Ave', 
                    city: 'New York City', 
                    latitude: rand(40.47399..40.917577), 
                    longitude: rand(73.700009..74.25909) * -1, 
                    goal: rand(10..1000)
                  )
  event.created_at = Time.now < start_time ? (Time.now - j.days) : (start_time - j.days)
  event.charities.push(Charity.all.sample)
  event.save
     k.times do 
      pledge = Pledge.new(event: event, donor: Donor.all.sample , amount: rand(5..10), status: "pending")
      pledge.created_at = rand(event.created_at..Time.now)
      pledge.save
    end 
end 


Charity.all.each do |charity|
  3.times do 
  CauseCharity.create(cause: Cause.all.sample , charity: charity)
  end 
end 



