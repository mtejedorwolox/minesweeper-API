class CreateCells < ActiveRecord::Migration[6.0]
  def change
    create_table :cells do |t|
      t.belongs_to :game, index: true
      t.integer :row, null: false
      t.integer :column, null: false
      t.integer :hiddenStatus, null: false, default: 0
      t.boolean :mine, null: false, default: false
      t.boolean :revealed, null: false, default: false
      t.integer :value

      t.timestamps
    end
  end
end
