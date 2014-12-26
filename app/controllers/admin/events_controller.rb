module Admin
  class EventsController < AdminController
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    # GET /events
    def index
      @events = Event.all
    end

    # GET /events/1
    def show
      attendee_subscribers = AttendeeApplication.mailinglist_subscribers.pluck(:emaiL)
      coach_subscribers = CoachApplication.mailinglist_subscribers.pluck(:email)
      @event_mailinglist_subscribers = attendee_subscribers + coach_subscribers
    end

    # GET /events/new
    def new
      @event = Event.new
    end

    # GET /events/1/edit
    def edit
    end

    # POST /events
    def create
      @event = Event.new(event_params)

      if @event.save
        redirect_to [:admin, @event], notice: 'Event was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /events/1
    def update
      if @event.update(event_params)
        redirect_to [:admin, @event], notice: 'Event was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /events/1
    def destroy
      @event.destroy
      redirect_to admin_events_url, notice: 'Event was successfully destroyed.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :description, :event_date, :coach_dinner_date, :coach_reg_start, :coach_reg_end, :attendee_reg_start, :attendee_reg_end)
    end
  end
end
