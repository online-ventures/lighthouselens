class Item < ApplicationRecord
  belongs_to :category

  has_many :photos, -> { order(featured: :desc, id: :asc) }
  has_many :buyers

  scope :published, -> { where(published: true) }

  validate :must_have_photo_to_publish

  def main_photo
    @main_photo ||= photos.limit(1).first
  end

  def check_photo_count
    update(published: false) if photos.count.none?
  end

  private

  def must_have_photo_to_publish
    if published_changed? and published and main_photo.blank?
      errors.add(:published, :no_photo, message: 'requires at least one photo')
    end
  end
end
