class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.json :ships_to
      t.json :urls

      t.timestamps
    end
  end
end
