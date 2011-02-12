class Report < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  belongs_to :state

  has_many :comments

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :state
  validates_presence_of :user
  validates_presence_of :category_id
  validates_presence_of :subject
  validates_presence_of :description

#  attached photo using paperclip
  has_attached_file :photo, :styles => {:medium => "306x238>"}
#  validates_attachment_content_type :photo, :content_type => ['image/jpeg']

end
