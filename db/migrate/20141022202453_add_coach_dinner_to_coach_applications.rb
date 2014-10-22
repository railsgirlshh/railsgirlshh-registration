class AddCoachDinnerToCoachApplications < ActiveRecord::Migration
  def change
    add_column :coach_applications, :coachdinner, :boolean, default: false
  end
end
