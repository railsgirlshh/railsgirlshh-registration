class CoachApplicationMailer < ActionMailer::Base
  layout 'email'
  add_template_helper(CoachApplicationsHelper)

  def welcome_email(coach_application)
    @coach_application = coach_application
    mail(to: @coach_application.email, subject: 'Rails Girls Hamburg Workshop')
  end
end
