class CreateTagsAndTaggings < ActiveRecord::Migration[6.0]
  def self.up
    create_table :tags do |t|
      t.string  :name,     null: false
      t.integer :category, default: 0

      t.timestamps null: false
    end

    create_table :taggings do |t|
      t.integer :tag_id,        null: false
      t.string  :taggable_type, null: false
      t.integer :taggable_id,   null: false

      t.timestamps null: false
    end

    add_index :tags,     :name
    add_index :tags,     :category
    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end