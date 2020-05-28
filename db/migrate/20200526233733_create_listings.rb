class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.integer :listing_type
      t.string :link
      t.string :currency
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
