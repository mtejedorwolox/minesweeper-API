class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :rows, null: false
      t.integer :columns, null: false
      t.integer :mines, null: false

      t.timestamps
    end
  end
end
