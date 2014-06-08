class CreateAttendeeApplications < ActiveRecord::Migration
  def change
    create_table :attendee_applications do |t|
      t.integer :event_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :female
      t.text :application_text
      t.text :prior_experience
      t.text :other_text

      t.timestamps
    end
  end
end
