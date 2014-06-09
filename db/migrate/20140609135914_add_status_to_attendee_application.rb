class AddStatusToAttendeeApplication < ActiveRecord::Migration
  def change
    add_column :attendee_applications, :status, :integer, default: 0
  end
end
