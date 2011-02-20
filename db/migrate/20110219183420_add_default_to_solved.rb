class AddDefaultToSolved < ActiveRecord::Migration
  def self.up
    change_column :reports, :solved, :boolean, :default => false
  end

  def self.down
    change_column :reports, :solved, :boolean
  end
end
