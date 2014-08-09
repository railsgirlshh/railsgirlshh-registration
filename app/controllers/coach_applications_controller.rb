class CoachApplicationsController < ApplicationController
  before_action :set_event
  before_action :set_coach_application_via_token, only: [:self_care, :cancel]

  def new
    if @event.coach_reg_open?
      @coach_application = @event.coach_applications.build
    else
      redirect_to root_url, notice: t('notice.coach.registration_not_open')
    end
  end

  def create
    if @event.coach_reg_open?
      @coach_application = @event.coach_applications.build(coach_application_params)

      if @coach_application.save
        redirect_to root_url, notice: t('notice.coach.registration_successful')
      else
        render :new
      end
    else
      redirect_to root_url, alert: t('notice.coach.registration_not_open')
    end
  end

  def self_care
  end

  def cancel
    if @coach_application.canceled!
      redirect_to root_url, notice: t('notice.coach.registration_canceled')
    else
      redirect_to root_url, alert: t('notice.coach.cancellation_error')
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('alert.event_not_found')
    redirect_to root_path
  end

  def set_coach_application_via_token
    @coach_application = CoachApplication.find_by token: params[:token], event: @event
    redirect_to root_url, alert: t('alert.application_not_found') unless @coach_application.present?
  end

  # Only allow a trusted parameter "white list" through.
  def coach_application_params
    params.require(:coach_application).permit(:event_id, :first_name, :last_name, :email, :application_text, :other_text)
  end
end
