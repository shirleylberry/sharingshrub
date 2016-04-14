class PledgeMailer < ApplicationMailer
  def pledge_creation_email(pledge)
    @user = pledge.donor.user
    @event = pledge.event
    @pledge = pledge
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Thanks for Donating to ' + @event.title + '!')
  end
end
