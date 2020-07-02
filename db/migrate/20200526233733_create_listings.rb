class CreateListings < ActiveRecord::Migration[6.0]
  def self.up
    create_table :listings do |t|
      t.boolean :available
      t.string  :country
      t.string  :currency
      t.string  :link
      t.decimal :price, precision: 10, scale: 2
      t.json    :sizes
      
      t.string     :listable_type, null: false
      t.integer    :listable_id,   null: false
      t.references :company,       null: false, foreign_key: true
      
      t.timestamps null: false
    end

    add_index :listings, [:listable_id, :listable_type]
  end

  def self.down
    drop_table :listings
  end
end