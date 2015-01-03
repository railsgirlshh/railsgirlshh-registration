class AttendeeApplicationsController < RegistrationsController
  before_action :set_event, except: [:self_care, :cancel]
  before_action :set_application_via_token, only: [:self_care, :cancel]

  private

  def model_class
    AttendeeApplication
  end

  def mailer_class
    AttendeeApplicationMailer
  end

  def registration
    @event.attendee_reg
  end

  def applications
    @event.attendee_applications
  end

  # Only allow a trusted parameter "white list" through.
  def application_params
    params.require(:attendee_application).permit(:event_id, :first_name, :last_name, :email, :age, :female, :application_text, :prior_experience, :other_text, :coc, :mailinglist_subscription)
  end
end
