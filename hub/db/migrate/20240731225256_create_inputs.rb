class CreateInputs < ActiveRecord::Migration[7.1]
  def change
    create_table :inputs do |t|
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
