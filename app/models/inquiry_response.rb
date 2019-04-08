class InquiryResponse < ApplicationRecord
  belongs_to :inquiry

  validates :inquiry_id, :code, presence: true
end
