class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.json :details
      t.references :product_line, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
