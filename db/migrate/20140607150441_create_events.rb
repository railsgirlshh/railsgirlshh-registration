class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.date :event_date
      t.date :coach_reg_start
      t.date :coach_reg_end
      t.date :attendee_reg_start
      t.date :attendee_reg_end

      t.timestamps
    end
  end
end
