class CoachApplicationsController < RegistrationsController
  before_action :set_event, except: [:self_care, :cancel, :cancel_dinner, :join_dinner]
  before_action :set_application_via_token, only: [:self_care, :cancel, :cancel_dinner, :join_dinner]

  def cancel_dinner
    if @application.update(coachdinner: false)
      redirect_to root_url, notice: t('notice.coach.dinner_canceled')
    else
      redirect_to root_url, alert: t('notice.coach.cancellation_error')
    end
  end

  def join_dinner
    if @application.update(coachdinner: true)
      redirect_to root_url, notice: t('notice.coach.dinner_joined')
    else
      redirect_to root_url, alert: t('notice.coach.cancellation_error')
    end
  end

  private

  def model_class
    CoachApplication
  end

  def mailer_class
    CoachApplicationMailer
  end

  def registration
    @event.coach_reg
  end

  def applications
    @event.coach_applications
  end

  # Only allow a trusted parameter "white list" through.
  def application_params
    params.require(:coach_application).permit(:event_id, :first_name, :last_name, :email, :other_text, :coachdinner, :coc, :mailinglist_subscription)
  end
end
