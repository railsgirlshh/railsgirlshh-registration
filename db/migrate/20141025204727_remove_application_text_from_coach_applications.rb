class RemoveApplicationTextFromCoachApplications < ActiveRecord::Migration
  def change
    remove_column :coach_applications, :application_text
  end
end
