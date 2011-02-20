class Report < ActiveRecord::Base
  acts_as_voteable
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

  #attached photo using paperclip
  #has_attached_file :photo, :styles => {:medium => "306x238>"}
  #validates_attachment_content_type :photo, :content_type => ['image/jpeg']

  has_many :assets, :dependent => :destroy
  accepts_nested_attributes_for :assets

  def self.total_on(date)
    where("date(created_at) = ?", date).count()
  end

  def self.total_month()
#  Article.count(:group=>"DATE_FORMAT(created_at, '%Y %b')")
    Report.count(:group=>"DATE_FORMAT(created_at, '%Y %b')")
#  where("date(created_at) = ?", datas).count()
  end

#  where("date(created_at) = ?", datas).count()

end
