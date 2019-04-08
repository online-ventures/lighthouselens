class Item < ApplicationRecord
  belongs_to :category
  has_many :inquiries
  has_many_attached :images

  scope :published, -> { where(published: true) }

  validate :must_have_photo_to_publish

  def main_photo
    images.first
  end

  def check_photo_count
    update(published: false) if images.count.none?
  end

  def blobs
    return @blobs if @blobs
    blob_ids = images.pluck :blob_id
    @blobs = ActiveStorage::Blob.where(id: blob_ids)
  end

  private

  def must_have_photo_to_publish
    if published_changed? and published and main_photo.blank?
      errors.add(:published, :no_photo, message: 'requires at least one photo')
    end
  end
end
