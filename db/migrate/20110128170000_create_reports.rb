class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.integer :state_id
      t.integer :user_id
      t.integer :category_id
      t.string :subject
      t.text :description
      t.string :coordinates
      t.string :file_path
      t.string :pincolor
      t.integer :voted

      t.timestamps
    end
    add_index(:reports, 'state_id')
    add_index(:reports, 'user_id')
    add_index(:reports, 'category_id')
  end

  def self.down
    drop_table :reports
  end
end
