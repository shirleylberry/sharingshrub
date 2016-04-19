# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# clears the database before seeding
ActiveRecord::Base.establish_connection
skipped_tables = ['schema_migrations', 'charities', 'causes', 'cause_charities']
ActiveRecord::Base.connection.tables.each do |table|
  # charities and causes are created with a rake task
  next if skipped_tables.include?(table)
  # MySQL and PostgreSQL
  # ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
  # SQLite
  ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
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
                    address: rand(10..1000).to_s + ' Broadway Ave NY', 
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
      event.update_funded_status_if_goal_reached
      pledge.save
    end 
end 



