class State < ActiveRecord::Base
  has_many :reports
  has_many :states
  belongs_to :state

end
