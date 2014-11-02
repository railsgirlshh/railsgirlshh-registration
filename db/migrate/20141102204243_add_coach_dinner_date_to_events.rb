class AddCoachDinnerDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :coach_dinner_date, :date
  end
end
