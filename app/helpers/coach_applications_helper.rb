module CoachApplicationsHelper

  def coach_self_care_url(coach_application)
    "#{root_url}c/#{coach_application.token}"
  end
end
