require_relative '../../test_helper'

module Admin
  class AttendeeApplicationsControllerTest < ActionController::TestCase
    setup do
      @event = events(:minimal_event)
      @attendee_application = attendee_applications(:one)
    end

    test "should get index" do
      get :index, event_id: @event.id
      assert_response :success
      assert_not_nil assigns(:attendee_applications)
    end

    test "should get new" do
      get :new, event_id: @event.id
      assert_response :success
    end

    test "should create attendee_application" do
      assert_difference('AttendeeApplication.count') do
        post :create, event_id: @attendee_application.event_id, attendee_application: { application_text: @attendee_application.application_text, email: @attendee_application.email, event_id: @attendee_application.event_id, female: @attendee_application.female, first_name: @attendee_application.first_name, last_name: @attendee_application.last_name, other_text: @attendee_application.other_text, prior_experience: @attendee_application.prior_experience, status: @attendee_application.status }
      end

      assert_redirected_to admin_event_attendee_application_path(@event, assigns(:attendee_application))
    end

    test "should show attendee_application" do
      get :show, event_id: @event.id, id: @attendee_application
      assert_response :success
    end

    test "should get edit" do
      get :edit, event_id: @attendee_application.event_id, id: @attendee_application
      assert_response :success
    end

    test "should update attendee_application" do
      patch :update, event_id: @attendee_application.event_id, id: @attendee_application, attendee_application: { application_text: @attendee_application.application_text, email: @attendee_application.email, event_id: @attendee_application.event_id, female: @attendee_application.female, first_name: @attendee_application.first_name, last_name: @attendee_application.last_name, other_text: @attendee_application.other_text, prior_experience: @attendee_application.prior_experience, status: @attendee_application.status}
      assert_redirected_to admin_event_attendee_application_path(@event, assigns(:attendee_application))
    end

    test "should destroy attendee_application" do
      assert_difference('AttendeeApplication.count', -1) do
        delete :destroy, event_id: @event.id, id: @attendee_application
      end

      assert_redirected_to admin_event_attendee_applications_path(@event)
    end
  end
end
