class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :entry_id
      t.integer :photo_id
      t.text :content
      t.timestamps
    end
    add_index :comments, :entry_id
    add_index :comments, :photo_id
  end

  def self.down
    drop_table :comments
  end
end
