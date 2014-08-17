# Preview all emails at http://localhost:3000/rails/mailers/attendee_application_mailer
class AttendeeApplicationMailerPreview < ActionMailer::Preview
 def welcome_email
    AttendeeApplicationMailer.welcome_email(AttendeeApplication.first)
 end
end
