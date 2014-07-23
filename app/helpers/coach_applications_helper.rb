module CoachApplicationsHelper

  def coach_self_care_url(coach_application)
    "#{root_url}/events/#{coach_application.event.id}/coach_applications/self_care/#{coach_application.token}"
  end
end
