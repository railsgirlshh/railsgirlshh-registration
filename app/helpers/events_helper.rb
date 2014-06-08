module EventsHelper
  def attendee_registration_display(event)
    if event.attendee_reg_open?
      "Register for this event. Registration closes #{event.attendee_reg_end_date.to_s(:long)}."
    elsif event.attendee_reg_end_date < Date.today
      "Registration is closed."
    elsif event.attendee_reg_start > Date.today
      "Registration opens #{event.attendee_reg_start.to_s(:long)} and closes #{event.attendee_reg_end_date.to_s(:long)}."
    end
  end

  def coach_registration_display(event)
    if event.coach_reg_open?
      "Register for this event. Registration closes #{event.coach_reg_end_date.to_s(:long)}."
    elsif event.coach_reg_end_date < Date.today
      "Registration is closed."
    elsif event.coach_reg_start > Date.today
      "Registration opens #{event.coach_reg_start.to_s(:long)} and closes #{event.coach_reg_end_date.to_s(:long)}."
    end
  end
end
