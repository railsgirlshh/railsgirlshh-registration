class AddTokenToAttendeeApplications < ActiveRecord::Migration
  def change
    add_column :attendee_applications, :token, :string
  end
end
