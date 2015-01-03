class AttendeeApplicationMailer < ActionMailer::Base
  layout 'email'
  add_template_helper(AttendeeApplicationsHelper)

  def welcome_email(attendee_application)
    @attendee_application = attendee_application
    mail(to: @attendee_application.email, subject: I18n.t('mail.attendee_welcome.subject'))
  end

  def accepted_email(attendee_application)
    @attendee_application = attendee_application
    mail(to: @attendee_application.email, subject: 'Teilnahme am Rails Girls Hamburg Workshop')
  end

  def rejected_email(attendee_application)
    @attendee_application = attendee_application
    mail(to: @attendee_application.email, subject: 'Keine Teilnahme am Rails Girls Hamburg Workshop')
  end
end
