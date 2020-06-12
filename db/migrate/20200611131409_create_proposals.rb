class CreateProposals < ActiveRecord::Migration[6.0]
  def self.up
    create_table :proposals do |t|
      t.string  :proposable_type, :default => ''
      t.integer :proposable_id
      t.json :proposed_change
      
      t.timestamps null: false
    end
    
    add_index :proposals, [:proposable_id, :proposable_type]
  end

  def self.down
    drop_table :proposals
  end
end
