class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.references :measure, null: false, foreign_key: true
      t.integer :stock
      t.float :value
      t.boolean :highlight
      t.string :details

      t.timestamps
    end
  end
end
