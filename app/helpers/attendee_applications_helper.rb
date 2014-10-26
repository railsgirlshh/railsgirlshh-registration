module AttendeeApplicationsHelper

  def attendee_self_care_url(attendee_application)
    "#{root_url}a/#{attendee_application.token}"
  end
end
