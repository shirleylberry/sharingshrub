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

require 'rails_helper'

describe Event do
  describe 'validations' do

    before do
      @event = build(:event)
    end

    it 'is a valid test Event' do
      expect(@event.save).to eq(true)
    end

    it 'is valid if it starts before it ends' do
      expect(@event.save).to eq(true)
    end

    it 'is invalid if it starts before it ends' do
      @event.event_start = Time.new(2016, 10, 11, 17) # 5pm
      @event.event_end = Time.new(2016, 10, 11, 9) # 9am
      expect(@event.save).to eq(false)
    end
    
#     it 'has at least one charity' do 
#       expect(@event.save).to eq(false)
#     end 

#     it 'has less than three charities' do 
#       @event.charities.empty
#       @event.charities.push(@charity1, @charity2, @charity3, @charity4)
#       expect(@event.save).to eq(false) 
#     end 
  end

  describe '#update_funded_status_if_goal_reached' do
    it 'updates the funded status if an event is funded' do
      @event = build(:event, :fully_funded)
      @event.update_funded_status_if_goal_reached
      expect(@event.funded).to be(true)
    end
  end

  describe '#total_raised_to_date' do
    it 'calculates the total raised' do
      @event = build(:event, :fully_funded)
      expect(@event.total_raised_to_date).to eq(500)
    end

    it 'returns 0 if an event has no pledges' do
      @event = build(:event)
      expect(@event.total_raised_to_date).to eq(0)
    end
  end

  describe '#amt_short_of_goal' do
    it 'calculates the total raised' do
      @event = build(:event, :not_funded)
      expect(@event.amt_short_of_goal).to eq(150)
    end

    it 'returns 0 if an event is fully funded' do
      @event = build(:event, :fully_funded)
      expect(@event.amt_short_of_goal).to eq(0)
    end
  end
end

