class ContactForm < MailForm::Base
  attribute :name
  attribute :email
  attribute :message

  validates :name, :email, :message, :presence => true

  def headers
    { :to => "said.kaldybaev" }
  end
end