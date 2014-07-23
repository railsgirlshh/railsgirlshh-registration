class CreateCoachApplication < ActiveRecord::Migration
  def change
    create_table :coach_applications do |t|
      t.integer :event_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :application_text
      t.text :other_text
      t.string :token
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
