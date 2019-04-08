class Inquiry < ApplicationRecord
  belongs_to :item

  validates :name, :email, :comments, presence: true
end
