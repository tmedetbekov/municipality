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

  time = Time.new
  scope :approved, where(:approved => true)
  scope :jan, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-01-01'), Date.parse(time.year.to_s+'-01-31')]} }
  scope :feb, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-02-01'), Date.parse(time.year.to_s+'-01-29')]} }
  scope :mar, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-03-01'), Date.parse(time.year.to_s+'-03-31')]} }
  scope :apr, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-04-01'), Date.parse(time.year.to_s+'-04-30')]} }
  scope :may, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-05-01'), Date.parse(time.year.to_s+'-05-31')]} }
  scope :jun, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-06-01'), Date.parse(time.year.to_s+'-06-30')]} }
  scope :jul, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-07-01'), Date.parse(time.year.to_s+'-07-31')]} }
  scope :aug, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-08-01'), Date.parse(time.year.to_s+'-08-31')]} }
  scope :sep, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-09-01'), Date.parse(time.year.to_s+'-09-30')]} }
  scope :oct, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-10-01'), Date.parse(time.year.to_s+'-10-31')]} }
  scope :nov, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-11-01'), Date.parse(time.year.to_s+'-11-30')]} }
  scope :dec, lambda { {:conditions => ['created_at > ? AND created_at < ?', Date.parse(time.year.to_s+'-12-01'), Date.parse(time.year.to_s+'-12-31')]} }

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


  def self.get_problem_count(state_id, is_solved)
    Report.where(:state_id => state_id, :solved => is_solved).count
  end
end
