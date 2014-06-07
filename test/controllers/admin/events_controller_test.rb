require_relative '../../test_helper'

module Admin
  class EventsControllerTest < ActionController::TestCase
    setup do
      @event = events(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:events)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create event" do
      assert_difference('Event.count') do
        post :create, event: { attendee_reg_end: @event.attendee_reg_end, attendee_reg_start: @event.attendee_reg_start, coach_reg_end: @event.coach_reg_end, coach_reg_start: @event.coach_reg_start, description: @event.description, event_date: @event.event_date, title: @event.title }
      end

      assert_redirected_to admin_event_path(assigns(:event))
    end

    test "should show event" do
      get :show, id: @event
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @event
      assert_response :success
    end

    test "should update event" do
      patch :update, id: @event, event: { attendee_reg_end: @event.attendee_reg_end, attendee_reg_start: @event.attendee_reg_start, coach_reg_end: @event.coach_reg_end, coach_reg_start: @event.coach_reg_start, description: @event.description, event_date: @event.event_date, title: @event.title }
      assert_redirected_to admin_event_path(assigns(:event))
    end

    test "should destroy event" do
      assert_difference('Event.count', -1) do
        delete :destroy, id: @event
      end

      assert_redirected_to admin_events_path
    end
  end
end
