class CommentAuthorMail < ActiveRecord::Migration
  def self.up
		add_column :comments, :email, :string
		remove_column :comments, :comment_id
  end

  def self.down
		remove_column :comments, :email
		add_column :comments, :comment_id, :integer
  end
end
