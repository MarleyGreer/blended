require 'test_helper'

class BookingMailerTest < ActionMailer::TestCase
  test "booking_request" do
    mail = BookingMailer.booking_request
    assert_equal "Booking request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
