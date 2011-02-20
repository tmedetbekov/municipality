class ChangeStringToTextDescription < ActiveRecord::Migration
  def self.up
    change_column("reports", "description", :text)
  end

  def self.down
    change_column("reports", "description", :string)
  end
end
