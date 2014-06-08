class AttendeeApplicationsController < ApplicationController
  before_action :set_event

  def new
    @attendee_application = @event.attendee_applications.build
  end

  def create
    @attendee_application = @event.attendee_applications.build(attendee_application_params) 

    if @attendee_application.save
      redirect_to root_url, notice: 'Attendee application was successfully created.'
    else
      render :new
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

  # Only allow a trusted parameter "white list" through.
  def attendee_application_params
    params.require(:attendee_application).permit(:event_id, :first_name, :last_name, :email, :female, :application_text, :prior_experience, :other_text)
  end
end
