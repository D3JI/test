class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.integer :user_id
      t.integer :boarder_id
      t.string :content
      t.string :reply
      t.timestamps
    end
    add_index :boards, :user_id
  end

  def self.down
    drop_table :boards
  end
end
