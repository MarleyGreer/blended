class BookingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.booking_request.subject
  #
  def booking_request(artist)
    @artist = artist
    mail(to: @artist.user.email, subject: 'You have a new booking request')
  end
end
