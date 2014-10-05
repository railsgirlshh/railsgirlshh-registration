require 'test_helper'

class AttendeeApplicationsControllerTest < ActionController::TestCase
  setup do
    @event = events(:minimal_event)
    @attendee_application = attendee_applications(:one)
  end

  test "should get new" do
    get :new, event_id: @event.id
    assert_response :success
  end

  test "should create attendee_application" do
    assert_difference('AttendeeApplication.count') do
      post :create, event_id: @attendee_application.event_id, attendee_application: { application_text: @attendee_application.application_text, email: @attendee_application.email, event_id: @attendee_application.event_id, female: @attendee_application.female, age: @attendee_application.age, first_name: @attendee_application.first_name, last_name: @attendee_application.last_name, other_text: @attendee_application.other_text, prior_experience: @attendee_application.prior_experience }
    end

    assert_redirected_to root_path
  end

  test "should not get new if registration is closed" do
    @event.attendee_reg_end= Date.today-1
    @event.save
    get :new, event_id: @event.id
    assert_redirected_to root_path
  end

  test "should not create attendee_application if registration is closed" do
    @event.attendee_reg_end= Date.today-1
    @event.save

    assert_no_difference('AttendeeApplication.count') do
      post :create, event_id: @attendee_application.event_id, attendee_application: { application_text: @attendee_application.application_text, email: @attendee_application.email, event_id: @attendee_application.event_id, female: @attendee_application.female,  age: @attendee_application.age, first_name: @attendee_application.first_name, last_name: @attendee_application.last_name, other_text: @attendee_application.other_text, prior_experience: @attendee_application.prior_experience }
    end

    assert_redirected_to root_path
  end

  test "should get self_care" do
    get :self_care, event_id: @attendee_application.event_id, token: @attendee_application.token
    assert_response :success
  end

  test "should cancel attendee_application" do
    assert_difference('AttendeeApplication.canceled.count') do
      post :cancel, event_id: @event.id, token: @attendee_application.token
    end

    assert_redirected_to root_path
  end

  test "should send welcome email when application is created" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create, event_id: @attendee_application.event_id, attendee_application: { application_text: @attendee_application.application_text, email: @attendee_application.email, event_id: @attendee_application.event_id, female: @attendee_application.female,  age: @attendee_application.age, first_name: @attendee_application.first_name, last_name: @attendee_application.last_name, other_text: @attendee_application.other_text, prior_experience: @attendee_application.prior_experience }
    end
    welcome_email = ActionMailer::Base.deliveries.last

    assert_equal "Rails Girls Hamburg Workshop", welcome_email.subject
    assert_equal @attendee_application.email, welcome_email.to[0]
    assert_match(/Hallo Ada/, welcome_email.body.to_s)
  end
end
