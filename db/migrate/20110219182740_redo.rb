class Redo < ActiveRecord::Migration
  def self.up
    change_column("reports", "description", :text, :default => "")
  end

  def self.down
    change_column("reports", "description", :string)
  end
end
