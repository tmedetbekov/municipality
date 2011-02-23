class Asset < ActiveRecord::Base
  belongs_to :report
  has_attached_file :image,
    :styles => {
        :thumb => "306x238>",
        :large => "600x600>",
        :marker => "220x165>"
    }
end
