module Admin
  class AttendeeApplicationsController < AdminController
    before_action :set_event
    before_action :set_attendee_application, only: [:show, :edit, :update, :destroy, :accept, :reject]
    before_action :set_statuses, only: [:new, :edit, :create, :update]

    def index
      @attendee_applications = @event.attendee_applications
    end

    def show
    end

    def new
      @attendee_application = @event.attendee_applications.build
    end

    def edit
    end

    def create
      @attendee_application = @event.attendee_applications.build(attendee_application_params)

      if @attendee_application.save
        redirect_to [:admin, @event, @attendee_application], notice: 'Attendee application was successfully created.'
      else
        render :new
      end
    end

    def update
      if @attendee_application.update(attendee_application_params)
        redirect_to [:admin, @event, @attendee_application], notice: 'Attendee application was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @attendee_application.destroy
      redirect_to admin_event_attendee_applications_url, notice: 'Attendee application was successfully destroyed.'
    end

    def accept
      transition_attendee_application_and_respond(:get_accepted!)
    end

    def reject
      transition_attendee_application_and_respond(:get_rejected!)
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendee_application
      @attendee_application = @event.attendee_applications.find(params[:id])
    end

    def set_statuses
      @statuses = AttendeeApplication.statuses
    end

    # Only allow a trusted parameter "white list" through.
    def attendee_application_params
      params.require(:attendee_application).permit(:event_id, :first_name, :last_name, :email, :age, :female, :application_text, :prior_experience, :other_text, :status, :coc)
    end

    def transition_attendee_application_and_respond(transition)
      respond_to do |format|
        if @attendee_application.send(transition)
          format.html { redirect_to [:admin, @event, @attendee_application], notice: 'Attendee application was successfully updated.' }
          format.js   { }
        else
          format.html { render action: "edit" }
          format.js   { render status: 500 }
        end
      end
    end
  end
end
