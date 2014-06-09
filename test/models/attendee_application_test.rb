require 'test_helper'
module AttendeeApplicationTest
  class AttendeeApplicationValidationTest < ActiveSupport::TestCase
    setup do
      @event = events(:minimal_event)
    end

    test "should not save attendee application without first name" do
      attendee_application = @event.attendee_applications.build(last_name: 'Foo', email: 'foo@example.com')
      assert_not attendee_application.save, "Saved the attendee application without a first name"
    end

    test "should not save attendee application without last name" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', email: 'foo@example.com')
      assert_not attendee_application.save, "Saved the attendee application without a last name"
    end

    test "should not save attendee application without email" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', last_name: 'bar')
      assert_not attendee_application.save, "Saved the attendee application without email"
    end

    test "should not save attendee application without event association" do
      attendee_application = AttendeeApplication.new(first_name: 'Foo', last_name: 'bar', email: 'foo@example.com')
      assert_not attendee_application.save, "Saved the attendee application without event association"
    end

    test "should save attendee application with mandatory data and set default status" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', last_name: 'bar', email: 'foo@example.com')
      assert attendee_application.save, "Did not save the attendee application with mandatory data"
      assert_equal attendee_application.status, "open", "did not set default status"
    end

    test "should save attendee application with full data" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', last_name: 'bar', email: 'foo@example.com', female: true, prior_experience: 'django', application_text: 'I want to learn rails', other_text: 'foo bar', status: 'rejected')
      assert attendee_application.save, "Did not save the attendee application with mandatory data"
    end
  end
end
