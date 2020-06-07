class CreatePatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :patterns do |t|
      t.string :name, null: false

      t.references :brand, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
