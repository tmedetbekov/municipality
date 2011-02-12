class Comment < ActiveRecord::Base
  belongs_to :report
  belongs_to :user

  validates_presence_of :content


end
