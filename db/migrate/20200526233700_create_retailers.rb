class CreateRetailers < ActiveRecord::Migration[6.0]
  def change
    create_table :retailers do |t|
      t.string :name
      t.string :url
      t.jsonb  :shipping

      t.timestamps
    end
  end
end
