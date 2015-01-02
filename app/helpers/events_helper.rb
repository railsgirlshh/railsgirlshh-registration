module EventsHelper
  def registration_display(registration)
    if registration.open?
      t 'events_helper.registration_open', registration_end_date: l(registration.end_date, format: :long)
    elsif registration.already_closed?
      t 'events_helper.registration_closed'
    elsif registration.not_started?
      t 'events_helper.registration_opens', registration_start_date: l(registration.start_date, format: :long), registration_end_date: l(registration.end_date, format: :long)
    end
  end
end
