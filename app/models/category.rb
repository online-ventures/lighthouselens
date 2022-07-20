class Category < ApplicationRecord
  has_many :items

  scope :active, -> { where.not(id: 0).order(:sequence, :id) }
end
