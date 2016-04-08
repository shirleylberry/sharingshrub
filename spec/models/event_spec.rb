# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  host_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_start :datetime
#  event_end   :datetime
#  funded      :boolean
#  goal        :float
#

require 'rails_helper'

describe Event do

  describe 'validations' do

    before(:each) do   
      # @shirley = User.create(name: "Shirley")
      # @jeff = User.create(name: "Jeff")
      # @ian = User.create(name: "Ian")
      # @bob = User.create(name: "Bob")
      # @ada  = User.create(name: "Ada")

      # @event1 = Event.new(title: "ShoeNami")
      # @event2 = Event.new(title: "HurricaneSeb")
      # @valid_event = Event.new(title: 'A Great, valid event' )
      # @invalid_event = Event.new(title: 'A terrible, invalid event' )

      @charityA = Charity.create(name: "A")
      @charityB = Charity.create(name: "B")
      @charityC = Charity.create(name: "C")
      @charityD = Charity.create(name: "D")
 
      @user = User.create(name: "User")
      @host = Host.create(user: @user)

      @event = Event.new(title: 'A Event', host_id: @host, goal: 1000, event_start: Time.new(2016, 8, 12, 10), event_end: Time.new(2016, 8, 12, 14) ) 
    
    end

    it 'is a valid test Event' do
      expect(@event.save).to eq(true)
    end

    it 'is valid if it starts before it ends' do
      expect(@event.save).to eq(true)
    end

    it 'is invalid if it starts before it ends' do
      @event.event_end = Time.new(2016, 10, 11, 9)
      expect(@event.save).to eq(false)
    end
    
    it 'has at least one charity' do 
      expect(@event.save).to eq(false)
    end 

    it 'has less than three charities' do 
      @event.charities.empty
      @event.charities.push(@charity1, @charity2, @charity3, @charity4)
      expect(@event.save).to eq(false) 
    end 

    # it 'has a description' do
    #   expect(listing.description).to eq("Whole house for rent on mountain. Many bedrooms.")
    # end

    # it 'has an address' do 
    #   expect(@listing1.address).to eq('123 Main Street')
    # end

    # it 'has a listing type' do 
    #   expect(@listing2.listing_type).to eq("shared room")
    # end

    # it 'has a price' do
    #   expect(@listing2.price).to eq(15.00)
    # end
  end
end
