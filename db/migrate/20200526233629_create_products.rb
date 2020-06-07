class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :manufacturer_code

      t.references :pattern,      null: false, foreign_key: true
      t.references :product_line, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
