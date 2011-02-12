class ReportAddress < ActiveRecord::Migration
  def self.up
		add_column :reports, :address, :string
  end

  def self.down
		remove_column :report, :address
  end
end
