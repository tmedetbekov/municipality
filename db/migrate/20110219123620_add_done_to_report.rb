class AddDoneToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :solved, :boolean
  end

  def self.down
    remove_column :reports, :solved
  end
end
