class Inquiry < ApplicationRecord
  belongs_to :item, optional: true
  has_many :responses, class_name: 'InquiryResponse'

  validates :name, :email, :comments, presence: true
end
