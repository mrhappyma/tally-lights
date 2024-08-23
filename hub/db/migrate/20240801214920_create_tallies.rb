class CreateTallies < ActiveRecord::Migration[7.1]
  def change
    create_table :tallies do |t|
      t.string :name
      t.boolean :on

      t.timestamps
    end
  end
end
