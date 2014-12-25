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
        post :create, event_id: @event.id, attendee_application: { application_text: @attendee_application.application_text, email: @attendee_application.email, event_id: @attendee_application.event_id, female: @attendee_application.female, age: @attendee_application.age, first_name: @attendee_application.first_name, last_name: @attendee_application.last_name, other_text: @attendee_application.other_text, prior_experience: @attendee_application.prior_experience, status: @attendee_application.status, coc: 1 }
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
      patch :update, event_id: @attendee_application.event_id, id: @attendee_application, attendee_application: { application_text: @attendee_application.application_text, email: @attendee_application.email, event_id: @attendee_application.event_id, female: @attendee_application.female,  age: @attendee_application.age, first_name: @attendee_application.first_name, last_name: @attendee_application.last_name, other_text: @attendee_application.other_text, prior_experience: @attendee_application.prior_experience, status: @attendee_application.status}
      assert_redirected_to admin_event_attendee_application_path(@event, assigns(:attendee_application))
    end

    test "should destroy attendee_application" do
      assert_difference('AttendeeApplication.count', -1) do
        delete :destroy, event_id: @event.id, id: @attendee_application
      end

      assert_redirected_to admin_event_attendee_applications_path(@event)
    end

    test "should accept attendee_application" do
      assert_difference('AttendeeApplication.accepted.count') do
        post :accept, event_id: @event.id, id: @attendee_application
      end

      assert_redirected_to admin_event_attendee_application_path(@event, assigns(:attendee_application))
    end

    test "should send email when attendee_application is rejected" do
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do
        post :reject, event_id: @event.id, id: @attendee_application
      end
      rejected_email = ActionMailer::Base.deliveries.last

      assert_equal "Absage für den Rails Girls Hamburg Workshop", rejected_email.subject
      assert_equal @attendee_application.email, rejected_email.to[0]
      assert_match(/Hallo Ada/, rejected_email.body.to_s)
    end

    test "should reject attendee_application" do
      assert_difference('AttendeeApplication.rejected.count') do
        post :reject, event_id: @event.id, id: @attendee_application
      end

      assert_redirected_to admin_event_attendee_application_path(@event, assigns(:attendee_application))
    end

    test "should send email when attendee_application is accepted" do
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do
        post :accept, event_id: @event.id, id: @attendee_application
      end
      accepted_email = ActionMailer::Base.deliveries.last

      assert_equal "Zusage für den Rails Girls Hamburg Workshop", accepted_email.subject
      assert_equal @attendee_application.email, accepted_email.to[0]
      assert_match(/Hallo Ada/, accepted_email.body.to_s)
    end
  end
end
