class Photo < ApplicationRecord
  belongs_to :item

  has_one_attached :file
end
