module Admin
  class CoachApplicationsController < ApplicationController
    before_action :set_event
    before_action :set_coach_application, only: [:show, :edit, :update, :destroy]
    before_action :set_statuses, only: [:new, :edit, :create, :update]

    def index
      @coach_applications = @event.coach_applications
    end

    def show
    end

    def new
      @coach_application = @event.coach_applications.build
    end

    def edit
    end

    def create
      @coach_application = @event.coach_applications.build(coach_application_params) 

      if @coach_application.save
        redirect_to [:admin, @event, @coach_application], notice: 'Coach application was successfully created.'
      else
        render :new
      end
    end

    def update
      if @coach_application.update(coach_application_params)
        redirect_to [:admin, @event, @coach_application], notice: 'Coach application was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @coach_application.destroy
      redirect_to admin_event_coach_applications_url, notice: 'Coach application was successfully destroyed.'
    end

 
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach_application
      @coach_application = @event.coach_applications.find(params[:id])
    end

    def set_statuses
      @statuses = CoachApplication.statuses
    end

    def set_event
      @event = Event.find(params[:event_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The event you were looking " +
        "for could not be found."
      redirect_to root_path
    end

    # Only allow a trusted parameter "white list" through.
    def coach_application_params
      params.require(:coach_application).permit(:event_id, :first_name, :last_name, :email, :application_text, :other_text, :status, :coachdinner)
    end
  end
end
