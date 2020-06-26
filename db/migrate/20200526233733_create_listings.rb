class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string  :company
      t.string  :currency
      t.json    :details
      t.integer :listing_type
      t.string  :link
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
