class AddInputToTallies < ActiveRecord::Migration[7.1]
  def change
    add_reference :tallies, :input, null: true, foreign_key: true
  end
end
