class RegistrationsController < ApplicationController
  def set_application_via_token
    @application = model_class.find_by token: params[:token]
    redirect_to root_url, alert: t('alert.application_not_found') unless @application.present?
    @event = @application.event
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
end
