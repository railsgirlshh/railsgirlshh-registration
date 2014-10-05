class AddAgeToAttendeeApplications < ActiveRecord::Migration
  def change
    add_column :attendee_applications, :age, :int
  end
end
