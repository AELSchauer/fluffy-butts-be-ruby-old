class CreateImagesAndImagings < ActiveRecord::Migration[6.0]
  def self.up
    create_table :images do |t|
      t.string :name, null: false
      t.string :link, null: false

      t.timestamps null: false
    end

    create_table :imagings do |t|
      t.integer :image_id

      t.string  :imagable_type, :default => ''
      t.integer :imagable_id

      t.timestamps null: false
    end

    add_index :images,   :name
    add_index :imagings, :image_id
    add_index :imagings, [:imagable_id, :imagable_type]
  end

  def self.down
    drop_table :imagings
    drop_table :images
  end
end