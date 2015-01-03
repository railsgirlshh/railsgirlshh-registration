class AddMailinglistSubscriptionToAttendeeApplications < ActiveRecord::Migration
  def change
    add_column :attendee_applications, :mailinglist_subscription, :boolean, default: false
  end
end
