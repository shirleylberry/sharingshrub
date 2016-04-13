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

  validates :host, presence: true
  validates :goal, presence: true
  validates :goal, numericality: { 
                   greater_than_or_equal_to: 50, message: "- your event must raise at least $50.", 
                   less_than_or_equal_to: 1000000, message: "- we limit goals to $1,000,000. Don't worry, you're event isn't limited in how much can be pledged!" 
                 } 
  validates :charities, length: { in: 1..3, :message => "Please select one to three charities your event will support." }
  validates :event_start, presence: true
  validates :event_end, presence: true
  validate :start_time_before_end_time
  validate :event_planned_at_least_two_weeks_out
  validate :event_planned_within_one_year

  # CUSTOM VALIDATIONS 
  def start_time_before_end_time
    if self.event_start && self.event_end
      if self.event_start >= self.event_end
        self.errors.add(:event_start, "- events cannot start before they end")
      end
    end
  end

  def event_planned_at_least_two_weeks_out
    if self.event_start && self.event_end
      if self.event_start < (Time.now + 14.days)
        self.errors.add(:event_start, "- events must be scheduled at least two-weeks out. Please have your event start on or after #{(Time.now + 14.days).to_date}")
      end
    end
  end

  def event_planned_within_one_year
    if self.event_start && self.event_end
      if self.event_start > (Time.now + 1.year)
        self.errors.add(:event_start, "- your event cannot be planned more than one year from today, #{(Time.now).to_date}")
      end
    end
  end

  # EVENT MODEL METHODS
  def update_funded_status_if_goal_reached
    self.update_attribute(:funded, true) if self.total_raised_to_date >= self.goal
  end

  def total_raised_to_date
    Pledge.where('pledges.event_id = ?', self.id).sum(:amount)
  end

  def amt_short_of_goal
    self.update_funded_status_if_goal_reached
    self.funded? ? 0 : self.goal - self.total_raised_to_date 
  end

  def growth_curve
    stop_time = self.event_end < Time.now ? self.event_end.to_i : Time.now.to_i
    time_interval = (self.created_at.to_i..stop_time).step(24.hours)
    points_array = self.pledges_over_time(time_interval)
    # new_arr = []

    # i = 0

    # while i < points_array.length - 1
    #   if points_array[i] == 0
    #     new_arr << points_array[i + 1]
    #   else
    #     calc = ((points_array[i + 1] - points_array[i]).to_f / points_array[i]) * 100
    #     new_arr << calc
    #     i += 1
    #   end
    # end
    # new_arr
    # growth_figs = []
    # points_array.each_with_index { |sum, i| growth_figs << ((sum)/ sum )*100 }
  end

  def pledges_over_time(range)
    range.collect do |date| 
      datetime = DateTime.strptime(date.to_s, "%s") 
      Pledge.where('created_at < ? AND event_id = ?', datetime, self.id).sum(:amount) 
    end
  end

  def self.upcoming_events(limit: 25)
    self.where('event_start > ?', Time.now).limit(limit)
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




