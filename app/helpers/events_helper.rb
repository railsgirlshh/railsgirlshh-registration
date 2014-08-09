module EventsHelper
  def attendee_registration_display(event)
    if event.attendee_reg_open?
     "#{t('events_helper.registration_open')} #{event.attendee_reg_end_date.to_s(:long)}"
    elsif event.attendee_reg_end_date < Date.today
      "#{t('events_helper.registration_closed')}"
    elsif event.attendee_reg_start > Date.today
      "#{t('events_helper.registration_opens')} #{event.attendee_reg_start.to_s(:long)} #{t('events_helper.registration_closes')} #{event.attendee_reg_end_date.to_s(:long)}."
    end
  end

  def coach_registration_display(event)
    if event.coach_reg_open?
      "#{t('events_helper.registration_open')} #{event.coach_reg_end_date.to_s(:long)}."
    elsif event.coach_reg_end_date < Date.today
      "#{t('events_helper.registration_closed')}"
    elsif event.coach_reg_start > Date.today
      "#{t('events_helper.registration_opens')} #{event.coach_reg_start.to_s(:long)} #{t('events_helper.registration_closes')} #{event.coach_reg_end_date.to_s(:long)}."
    end
  end
end
