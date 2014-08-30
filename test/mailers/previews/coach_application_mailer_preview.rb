# Preview all emails at http://localhost:3000/rails/mailers/coach_application_mailer
class CoachApplicationMailerPreview < ActionMailer::Preview
 def welcome_email
    CoachApplicationMailer.welcome_email(CoachApplication.first)
 end
end
