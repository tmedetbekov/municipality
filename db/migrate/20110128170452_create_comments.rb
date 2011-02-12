class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :report_id
      t.integer :comment_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
    add_index(:comments, 'report_id')
    add_index(:comments, 'comment_id')
    add_index(:comments, 'user_id')
  end

  def self.down
    drop_table :comments
  end
end
