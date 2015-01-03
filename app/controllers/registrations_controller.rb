class RegistrationsController < ApplicationController

  def new
    if registration.open?
      @application = applications.build
    else
      redirect_to root_url, notice:  t('notice.registration_not_open')
    end
  end

  def create
    if registration.open?
      @application = applications.build(application_params)

      if @application.save
        redirect_to root_url, notice: t('notice.registration_successful')
        mailer_class.welcome_email(@application).deliver
      else
        render :new
      end
    else
      redirect_to root_url, alert: t('notice.registration_not_open')
    end
  end

  def self_care
  end

  def cancel
    if @application.canceled!
      redirect_to root_url, notice: t('notice.registration_canceled')
    else
      redirect_to root_url, alert: t('notice.cancellation_error')
    end
  end

  private

  def set_application_via_token
    @application = model_class.find_by token: params[:token]
    redirect_to root_url, alert: t('alert.application_not_found') unless @application.present?
    @event = @application.event
  end
end
