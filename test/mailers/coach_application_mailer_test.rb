require 'test_helper'

class CoachApplicationMailerTest < ActionMailer::TestCase

  test "welcome_email" do
    coach_application = coach_applications(:one)
    # Send the email, then test that it got queued
    email = CoachApplicationMailer.welcome_email(coach_application).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal ['railsgirlshh@gmail.com'], email.from
    assert_equal [coach_application.email], email.to
    assert_equal 'Rails Girls Hamburg Workshop', email.subject
  end
end
