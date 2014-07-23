class CoachApplicationsController < ApplicationController
  before_action :set_event
  before_action :set_coach_application_via_token, only: [:self_care, :cancel]

  def new
    if @event.coach_reg_open?
      @coach_application = @event.coach_applications.build
    else
      redirect_to root_url, notice: 'Coach application is not open.'
    end
  end

  def create
    if @event.coach_reg_open?
      @coach_application = @event.coach_applications.build(coach_application_params)

      if @coach_application.save
        redirect_to root_url, notice: 'Coach application was successfully created.'
      else
        render :new
      end
    else
      redirect_to root_url, alert: 'Coach application is not open.'
    end
  end

  def self_care
  end

  def cancel
    if @coach_application.canceled!
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

  def set_coach_application_via_token
    @coach_application = CoachApplication.find_by token: params[:token], event: @event
    redirect_to root_url, alert: 'We could not find your application.' unless @coach_application.present?
  end

  # Only allow a trusted parameter "white list" through.
  def coach_application_params
    params.require(:coach_application).permit(:event_id, :first_name, :last_name, :email, :application_text, :other_text)
  end
end
