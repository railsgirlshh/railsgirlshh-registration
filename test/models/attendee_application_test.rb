require 'test_helper'
module AttendeeApplicationTest
  class AttendeeApplicationValidationTest < ActiveSupport::TestCase
    setup do
      @event = events(:minimal_event)
    end

    test "should not save attendee application without first name" do
      attendee_application = @event.attendee_applications.build(last_name: 'Foo', email: 'foo@example.com', coc: "1")
      assert_not attendee_application.save, "Saved the attendee application without a first name"
    end

    test "should not save attendee application without last name" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', email: 'foo@example.com', coc: "1")
      assert_not attendee_application.save, "Saved the attendee application without a last name"
    end

    test "should not save attendee application without email" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', last_name: 'bar', coc: "1")
      assert_not attendee_application.save, "Saved the attendee application without email"
    end

    test "should not save attendee application without coc acceptance" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', last_name: 'bar', email: 'foo@example.com')
      assert_not attendee_application.save, "Saved the attendee application without coc acceptance"
    end

    test "should not save attendee application without event association" do
      attendee_application = AttendeeApplication.new(first_name: 'Foo', last_name: 'bar', email: 'foo@example.com', coc: "1")
      assert_not attendee_application.save, "Saved the attendee application without event association"
    end

    test "should save attendee application with mandatory data and set default status" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', last_name: 'bar', email: 'foo@example.com', coc: "1")
      assert attendee_application.save, "Did not save the attendee application with mandatory data"
      assert_equal "open", attendee_application.status, "did not set default status"
    end

    test "should save attendee application with full data" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', last_name: 'bar', age: 18, email: 'foo@example.com', female: true, prior_experience: 'django', application_text: 'I want to learn rails', other_text: 'foo bar', status: 'rejected', coc: "1")
      assert attendee_application.save, "Did not save the attendee application with full data"
    end

    test "should not save without valid email" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', last_name: 'bar', email: 'fooexample.com', coc: "1")
      assert_not attendee_application.save, "Saved the attendee application without valid email"
    end

    test "should not save with invalid age" do
      attendee_application = @event.attendee_applications.build(first_name: 'Foo', last_name: 'bar', email: 'foo@example.com', age: 'xxx', coc: "1")
      assert_not attendee_application.save, "Saved the attendee application without invalid age"
    end
  end

  class AttendeeApplicationGetRejected < ActiveSupport::TestCase
    setup do
      @event = events(:minimal_event)
    end

    test "should reject attendee_application" do
      @attendee_application = @event.attendee_applications.build(last_name: 'Foo', first_name: 'Ada', email: 'foo@example.com', coc: "1")
      assert_difference('AttendeeApplication.rejected.count') do
        @attendee_application.get_rejected!
      end
    end

    test "should send email when attendee_application is rejected" do
      @attendee_application = @event.attendee_applications.build(last_name: 'Foo', first_name: 'Ada', email: 'foo@example.com', coc: "1")

      assert_difference 'ActionMailer::Base.deliveries.size', +1 do
        @attendee_application.get_rejected!
      end

      rejected_email = ActionMailer::Base.deliveries.last

      assert_equal "Absage für den Rails Girls Hamburg Workshop", rejected_email.subject
      assert_match(/Hallo Ada/, rejected_email.body.to_s)

      assert_equal @attendee_application.email, rejected_email.to[0]
    end
  end

  class AttendeeApplicationGetAccepted < ActiveSupport::TestCase
    setup do
      @event = events(:minimal_event)
    end

    test "should accept attendee_application" do
      @attendee_application = @event.attendee_applications.build(last_name: 'Foo', first_name: 'Ada', email: 'foo@example.com', coc: "1")
      assert_difference('AttendeeApplication.accepted.count') do
        @attendee_application.get_accepted!
      end
    end

    test "should send email when attendee_application is accepted" do
      @attendee_application = @event.attendee_applications.build(last_name: 'Foo', first_name: 'Ada', email: 'foo@example.com', coc: "1")
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do
        @attendee_application.get_accepted!
      end

      accepted_email = ActionMailer::Base.deliveries.last

      assert_equal "Zusage für den Rails Girls Hamburg Workshop", accepted_email.subject
      assert_match(/Hallo Ada/, accepted_email.body.to_s)

      assert_equal @attendee_application.email, accepted_email.to[0]
    end
  end
end
