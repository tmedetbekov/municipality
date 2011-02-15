class Comment < ActiveRecord::Base
  belongs_to :report
  belongs_to :user

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :content
	validates_presence_of :author
	validates_presence_of :email
  validates_format_of :email, :with => EMAIL_REGEX


end
