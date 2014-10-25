require 'test_helper'
module CoachApplicationTest
  class CoachApplicationValidationTest < ActiveSupport::TestCase
    setup do
      @event = events(:minimal_event)
    end

    test "should not save coach application without first name" do
      coach_application = @event.coach_applications.build(last_name: 'Foo', email: 'foo@example.com')
      assert_not coach_application.save, "Saved the coach application without a first name"
    end

    test "should not save coach application without last name" do
      coach_application = @event.coach_applications.build(first_name: 'Foo', email: 'foo@example.com')
      assert_not coach_application.save, "Saved the coach application without a last name"
    end

    test "should not save coach application without email" do
      coach_application = @event.coach_applications.build(first_name: 'Foo', last_name: 'bar')
      assert_not coach_application.save, "Saved the coach application without email"
    end

    test "should not save coach application without event association" do
      coach_application = CoachApplication.new(first_name: 'Foo', last_name: 'bar', email: 'foo@example.com')
      assert_not coach_application.save, "Saved the coach application without event association"
    end

    test "should save coach application with mandatory data and set default status" do
      coach_application = @event.coach_applications.build(first_name: 'Foo', last_name: 'bar', email: 'foo@example.com')
      assert coach_application.save, "Did not save the coach application with mandatory data"
      assert_equal "registered", coach_application.status, "did not set default status"
    end

    test "should save coach application with full data" do
      coach_application = @event.coach_applications.build(first_name: 'Foo', last_name: 'bar', email: 'foo@example.com', other_text: 'foo bar', status: 'registered', coachdinner: true)
      assert coach_application.save, "Did not save the coach application with full data"
    end

    test "should not save without valid email" do
      coach_application = @event.coach_applications.build(first_name: 'Foo', last_name: 'bar', email: 'fooexample.com')
      assert_not coach_application.save, "Saved the coach application without valid email"
    end
  end
end
