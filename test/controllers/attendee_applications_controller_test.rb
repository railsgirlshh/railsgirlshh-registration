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
      post :create, event_id: @attendee_application.event_id, attendee_application: { application_text: @attendee_application.application_text, email: @attendee_application.email, event_id: @attendee_application.event_id, female: @attendee_application.female, first_name: @attendee_application.first_name, last_name: @attendee_application.last_name, other_text: @attendee_application.other_text, prior_experience: @attendee_application.prior_experience }
    end

    assert_redirected_to root_path
  end
end
