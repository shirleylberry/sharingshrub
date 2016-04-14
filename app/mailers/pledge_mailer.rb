class PledgeMailer < ApplicationMailer
  def pledge_creation_email(pledge)
    @pledge = pledge
    @user = @pledge.donor.user
    @event = @pledge.event
    @url  = event_url(@event)
    # binding.pry
    mail(to: @user.email, subject: 'Thanks for Donating to ' + @event.title + '!')
  end
end
