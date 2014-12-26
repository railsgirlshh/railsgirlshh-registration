class AddMailinglistSubscriptionToCoachApplications < ActiveRecord::Migration
  def change
    add_column :coach_applications, :mailinglist_subscription, :boolean, default: false
  end
end
