module EventsHelper
  def attendee_registration_display(event)
    if event.attendee_reg_open?
     t 'events_helper.attendee_registration_open', application_end_date: l(event.attendee_reg_end_date, format: :long)
    elsif event.attendee_reg_end_date < Date.today
      t 'events_helper.attendee_registration_closed'
    elsif event.attendee_reg_start > Date.today
      t 'events_helper.attendee_registration_opens', application_start_date: l(event.attendee_reg_start, format: :long), application_end_date: l(event.attendee_reg_end_date, format: :long)
    end
  end

  def coach_registration_display(event)
    if event.coach_reg_open?
      t 'events_helper.coach_registration_open', registration_end_date: l(event.coach_reg_end_date, format: :long)
    elsif event.coach_reg_end_date < Date.today
      t 'events_helper.coach_registration_closed'
    elsif event.coach_reg_start > Date.today
      t 'events_helper.coach_registration_opens', registration_start_date: l(event.coach_reg_start, format: :long), registration_end_date: l(event.coach_reg_end_date, format: :long)
    end
  end
end
