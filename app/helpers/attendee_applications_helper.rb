module AttendeeApplicationsHelper

  def attendee_self_care_url(attendee_application)
    "#{root_url}/events/#{attendee_application.event.id}/attendee_applications/self_care/#{attendee_application.token}"
  end
end
