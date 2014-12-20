class AttendeeApplicationMailer < ActionMailer::Base
  layout 'email'
  add_template_helper(AttendeeApplicationsHelper)

  def welcome_email(attendee_application)
    @attendee_application = attendee_application
    mail(to: @attendee_application.email, subject: I18n.t('mailer.attendee_application.welcome_email.subject'))
  end

  def accepted_email(attendee_application)
    @attendee_application = attendee_application
    mail(to: @attendee_application.email, subject: I18n.t('mailer.attendee_application.accepted_email.subject'))
  end

  def rejected_email(attendee_application)
    @attendee_application = attendee_application
    mail(to: @attendee_application.email, subject: I18n.t('mailer.attendee_application.rejected_email.subject'))
  end
end
