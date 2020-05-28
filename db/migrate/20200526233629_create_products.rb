class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :product_line, null: false, foreign_key: true
      t.string :manufacturer_code

      t.timestamps null: false
    end
  end
end
