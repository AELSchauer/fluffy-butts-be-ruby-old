class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.json :details

      t.references :pattern,      null: true,  foreign_key: true
      t.references :product_line, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
