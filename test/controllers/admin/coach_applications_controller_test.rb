require_relative '../../test_helper'

module Admin
  class CoachApplicationsControllerTest < ActionController::TestCase
    setup do
      @event = events(:minimal_event)
      @coach_application = coach_applications(:one)
    end

    test "should get index" do
      get :index, event_id: @event.id
      assert_response :success
      assert_not_nil assigns(:coach_applications)
    end

    test "should get new" do
      get :new, event_id: @event.id
      assert_response :success
    end

    test "should create coach_application" do
      assert_difference('CoachApplication.count') do
        post :create, event_id: @event.id, coach_application: { application_text: @coach_application.application_text, email: @coach_application.email, event_id: @coach_application.event_id, first_name: @coach_application.first_name, last_name: @coach_application.last_name, other_text: @coach_application.other_text, coachdinner: true, status: @coach_application.status }
      end

      assert_redirected_to admin_event_coach_application_path(@event, assigns(:coach_application))
    end

    test "should show coach_application" do
      get :show, event_id: @event.id, id: @coach_application
      assert_response :success
    end

    test "should get edit" do
      get :edit, event_id: @coach_application.event_id, id: @coach_application
      assert_response :success
    end

    test "should update coach_application" do
      patch :update, event_id: @coach_application.event_id, id: @coach_application, coach_application: { application_text: @coach_application.application_text, email: @coach_application.email, event_id: @coach_application.event_id, first_name: @coach_application.first_name, last_name: @coach_application.last_name, other_text: @coach_application.other_text, coachdinner: true, status: @coach_application.status}
      assert_redirected_to admin_event_coach_application_path(@event, assigns(:coach_application))
    end

    test "should destroy coach_application" do
      assert_difference('CoachApplication.count', -1) do
        delete :destroy, event_id: @event.id, id: @coach_application
      end

      assert_redirected_to admin_event_coach_applications_path(@event)
    end
  end
end
