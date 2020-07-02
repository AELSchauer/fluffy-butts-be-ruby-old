class CreateBulkPacks < ActiveRecord::Migration[6.0]
  def change
    create_table :bulk_packs do |t|
      t.string  :name
      t.integer :quantity
      t.references :product_line, null: false, foreign_key: true

      t.timestamps
    end
  end
end
