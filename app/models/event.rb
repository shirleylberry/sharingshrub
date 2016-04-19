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
#  address         :string
#  city            :string
#  latitude        :float
#  longitude       :float
#  description     :string
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

  def self.upcoming_events(limit: 100)
    self.where('event_start > ?', Time.now).limit(100)
  end 

  def send_emails_if_funded
    EventMailer.event_funded_donors_email(self).deliver_now
    EventMailer.event_funded_host_email(self).deliver_now
  end

  # EVENT MODEL METHODS
  def update_funded_status_if_goal_reached
    if self.total_raised_to_date >= self.goal && self.funded == false
      self.update_attribute(:funded, true) 
      self.send_emails_if_funded
    end
  end
  
  def total_raised_to_date
    Pledge.where('pledges.event_id = ?', self.id).sum(:amount)
  end

  def percentage_raised_fund
    (self.total_raised_to_date/ self.goal * 100).round
  end 

  def amt_short_of_goal
    # self.update_funded_status_if_goal_reached
    self.funded? ? 0 : self.goal - self.total_raised_to_date 
  end

  def self.number_of_events(cause)
    joins(:causes).where(cause: cause).count
  end 
  

  # ex.[{date: Thu, 24 Mar 2016 05:00:00 +0000, amount: 20 }]
  def pledges_over_time(start, stop)
    start = start.to_i
    stop = (stop + 1.day).to_i
    interval = (start..stop).step(24.hours)
    pledge_data = Array.new

    interval.each_with_index do |day, i| 
      pledge_data[i] = Hash.new
      amount_to_date =  Pledge.where('created_at <= ? AND event_id = ?', Time.at(day), self.id).sum(:amount) 
      pledge_data[i][:date] = Time.at(day).strftime("%B %d")
      pledge_data[i][:amount] = amount_to_date
    end
    pledge_data
  end

  #ex.[{period: 1, ratio: 12.234}]
  def growth_curve
    start_time = self.created_at
    stop_time = self.event_end < Time.now ? self.event_end : Time.now  
    daily_pledge_sum = self.pledges_over_time(start_time, stop_time).map { |total| total[:amount] }
    growth_data = Array.new 
    
    i = 1
    while i < daily_pledge_sum.count
       growth_data[i] = Hash.new
      if daily_pledge_sum[i-1] == 0
        growth_ratio = 0 
      else  
        growth_ratio = ((daily_pledge_sum[i] - (daily_pledge_sum[i-1]).to_f)/ daily_pledge_sum[i-1]) * 100    
      end  
        growth_data[i][:period] = i
        growth_data[i][:ratio] = growth_ratio
        i += 1   
     end
    growth_data.compact
  end

  def self.upcoming_events(limit: 15)
    self.where('event_start > ?', Time.now).limit(15)
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

  def self.list(cause_or_charity)
    if cause_or_charity.class == Cause 
    joins(:causes).where(causes: {id: cause_or_charity.id})
    elsif cause_or_charity.class == Charity
    joins(:charities).where(charities: {id: cause_or_charity.id})
    else
    none 
    end 
  end


end




