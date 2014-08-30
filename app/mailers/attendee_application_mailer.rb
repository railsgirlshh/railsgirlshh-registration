class AttendeeApplicationMailer < ActionMailer::Base
  add_template_helper(AttendeeApplicationsHelper)

  def welcome_email(attendee_application)
    @attendee_application = attendee_application
    mail(to: @attendee_application.email, subject: 'Rails Girls Hamburg Workshop')
  end

  def accepted_email(attendee_application)
    @attendee_application = attendee_application
    mail(to: @attendee_application.email, subject: 'Teilnahme am Rails Girls Hamburg Workshop')
  end
end
