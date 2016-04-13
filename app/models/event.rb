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

class Event < ActiveRecord::Base
  include MultiparameterDateTime

  multiparameter_date_time :event_start
  multiparameter_date_time :event_end
  
  belongs_to :host
  has_many :event_charities
  has_many :charities, through: :event_charities
  has_many :causes, through: :charities
  has_many :pledges
  has_many :donors, through: :pledges

  # validates :host, presence: true
  # validates :charities, length: {in: 1..3}
  validate :start_time_before_end_time

  #validates user input of the event date
  def start_time_before_end_time
    if self.event_start >= self.event_end
      self.errors.add(:event_start, "must be before event end")
    end
  end
 
  def update_funded_status_if_goal_reached
    self.update_attribute(:funded, true) if self.total_raised_to_date >= self.goal
  end
  
  def total_raised_to_date
    Pledge.where('pledges.event_id = ?', self.id).sum(:amount)
  end

  def percentage_raised_fund
    (self.total_raised_to_date/ self.goal * 100).round
  end 

  def amt_short_of_goal
    self.funded? ? 0 : self.goal - self.total_raised_to_date 
  end


  # #takes period, an array argument(day_interval), 
  # #returns the array of pledges(amount) raised on each day during the period given. 
  # def pledges_over_time(day_interval)
  #   day_inverval.collect do |date| 
  #     datetime = DateTime.strptime(date.to_s, "%s") 
  #     Pledge.where('created_at < ? AND event_id = ?', datetime, self.id).sum(:amount) 
  #   end
  # end

  # def growth_curve
  #   stop_time = self.event_end < Time.now ? self.event_end.to_i : Time.now.to_i
  #   time_interval = (self.created_at.to_i..stop_time).step(24.hours)
  #  binding.pry
  #   points_array = self.pledges_over_time(time_interval)
   
  #   new_arr = []

  #   # i = 0

  #   # while i < points_array.length - 1
  #   #   if points_array[i] == 0
  #   #     new_arr << points_array[i + 1]
  #   #   else
  #   #     calc = ((points_array[i + 1] - points_array[i]).to_f / points_array[i]) * 100
  #   #     new_arr << calc
  #   #     i += 1
  #   #   end
  #   # end
  #   # new_arr
  #   # growth_figs = []
  #   # points_array.each_with_index { |sum, i| growth_figs << ((sum)/ sum )*100 }
  # end

 

  def self.upcoming_events
    self.where('event_start > ?', Time.now).limit(25)
  end

  def is_on?(start_date, end_date)
    range = (start_date..end_date)
    range.cover?(self.event_start) && range.cover?(self.event_end)
  end 

  def self.events_between(start_date, end_date)   
    Event.where('events.event_start < ? AND events.event_end > ?', end_date, start_date)
    # Event.all.select { |event| event.is_on?(start_date, end_date) }  
  end

  def average_pledge
    Pledge.where(event_id: self.id).average(:amount).to_f
  end

  def funded_deadline_passed?
    self.funded_deadline >= Time.now
  end

  def event_has_ended?
  end
end




