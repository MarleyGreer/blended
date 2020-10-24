# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/booking_request
  def booking_request
    artist = Artist.first
    BookingMailer.booking_request(artist)
  end

end
