class EventMailer < ApplicationMailer
  def event_funded_host_email(event)
    @event = event
    @user = @event.host.user
    @url  = event_url(@event)
    mail(to: @user.email, subject: 'Your event ' + @event.title + 'has been funded!')
  end

  def event_funded_donors_email(event)
    @event = event
    @url  = event_url(@event)
    emails = @event.donors.map{|donor| donor.email}
    mail(to: emails, subject: 'An event you pledged to has been funded!')
  end
end
