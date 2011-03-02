class AddColumnToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :approved, :boolean, :default => false
  end

  def self.down
    remove_column :reports, :approved
  end
end
