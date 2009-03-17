class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :user_id
      t.integer :comments_count, :defualt => 0
      t.string :title
      t.text :content
      t.timestamps
    end
    add_index :entries, :user_id
    add_column :users, :entries_count, :integer
  end

  def self.down
    drop_table :entries
  end
end
