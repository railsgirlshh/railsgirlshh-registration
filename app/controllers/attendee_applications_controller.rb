class AttendeeApplicationsController < RegistrationsController
  before_action :set_event, except: [:self_care]
  before_action :set_application_via_token, only: [:self_care, :cancel]


  def new
    if @event.attendee_reg.open?
      @attendee_application = @event.attendee_applications.build
    else
      redirect_to root_url, notice:  t('notice.attendee.registration_not_open')
    end
  end

  def create
    if @event.attendee_reg.open?
      @attendee_application = @event.attendee_applications.build(attendee_application_params)

      if @attendee_application.save
        redirect_to root_url, notice: t('notice.attendee.registration_successful')
        AttendeeApplicationMailer.welcome_email(@attendee_application).deliver
      else
        render :new
      end
    else
      redirect_to root_url, alert: t('notice.attendee.registration_not_open')
    end
  end

  private

  def model_class
    AttendeeApplication
  end

  # Only allow a trusted parameter "white list" through.
  def attendee_application_params
    params.require(:attendee_application).permit(:event_id, :first_name, :last_name, :email, :age, :female, :application_text, :prior_experience, :other_text, :coc, :mailinglist_subscription)
  end
end
