desc 'Get cause data from web scraper and create causes'
  task :create_causes => :environment do
    include Adapters
    ActiveRecord::Base.connection.execute("DELETE FROM CAUSES")
    connection = Adapters::CharityWatchConnection.new
    cause_names = connection.get_cause_names
    client = Adapters::CauseClient.new
    client.create_causes(cause_names)
  end

desc 'Get charities data from web scraper and create charities'
  task :create_charities => :environment do
    include Adapters
    ActiveRecord::Base.connection.execute("DELETE FROM CHARITIES")
    connection = Adapters::CharityWatchConnection.new
    charities = connection.get_charities
    client = Adapters::CharityClient.new
    client.create_charities(charities)
  end

desc 'delete charities with duplicate names'
  task :delete_duplicate_charities => :environment do
    grouped = Charity.all.group_by{|charity| charity.name}
    grouped.values.each do |groups|
      first_one = groups.shift
      groups.each{|duplicate| duplicate.destroy }
    end
  end