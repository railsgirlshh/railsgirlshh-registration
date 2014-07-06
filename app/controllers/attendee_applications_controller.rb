class AttendeeApplicationsController < ApplicationController
  before_action :set_event
  before_action :set_attendee_application_via_token, only: [:self_care, :cancel]

  def new
    if @event.attendee_reg_open?
      @attendee_application = @event.attendee_applications.build
    else
      redirect_to root_url, notice: 'Attendee application is not open.'
    end
  end

  def create
    if @event.attendee_reg_open?
      @attendee_application = @event.attendee_applications.build(attendee_application_params)

      if @attendee_application.save
        redirect_to root_url, notice: 'Attendee application was successfully created.'
      else
        render :new
      end
    else
      redirect_to root_url, alert: 'Attendee application is not open.'
    end
  end

  def self_care
  end

  def cancel
    if @attendee_application.canceled!
      redirect_to root_url, notice: 'Your application has been canceled.'
    else
      redirect_to root_url, alert: 'Something went wrong when trying to cancel your application.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The event you were looking " +
                      "for could not be found."
    redirect_to root_path
  end

  def set_attendee_application_via_token
    @attendee_application = AttendeeApplication.find_by token: params[:token], event: @event
    redirect_to root_url, alert: 'We could not finde your application.' unless @attendee_application.present?
  end

  # Only allow a trusted parameter "white list" through.
  def attendee_application_params
    params.require(:attendee_application).permit(:event_id, :first_name, :last_name, :email, :female, :application_text, :prior_experience, :other_text)
  end
end
