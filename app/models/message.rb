class Message
  include ActiveModel::Model

  attr_accessor :name, :email, :body, :item_id

  validates :name, :email, :body, presence: true
end
