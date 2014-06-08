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
  end
end
