class CreateProductListings < ActiveRecord::Migration[6.0]
  def change
    create_table :product_listings do |t|
      t.references :product, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
