class AttendeeApplicationsController < ApplicationController
  before_action :set_event, except: [:self_care]
  before_action :set_attendee_application_via_token, only: [:self_care, :cancel]


  def new
    if @event.attendee_reg_open?
      @attendee_application = @event.attendee_applications.build
    else
      redirect_to root_url, notice:  t('notice.attendee.registration_not_open')
    end
  end

  def create
    if @event.attendee_reg_open?
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

  def self_care
  end

  def cancel
    if @attendee_application.canceled!
      redirect_to root_url, notice: t('notice.attendee.registration_canceled')
    else
      redirect_to root_url, alert: t('notice.attendee.cancellation_error')
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('alert.event_not_found')

    redirect_to root_path
  end

  def set_attendee_application_via_token
    @attendee_application = AttendeeApplication.find_by token: params[:token]
    redirect_to root_url, alert: t('alert.application_not_found') unless @attendee_application.present?
    @event = @attendee_application.event
  end

  # Only allow a trusted parameter "white list" through.
  def attendee_application_params
    params.require(:attendee_application).permit(:event_id, :first_name, :last_name, :email, :age, :female, :application_text, :prior_experience, :other_text, :coc)
  end
end
