class Item < ApplicationRecord
  include Activeable

  belongs_to :category
  has_many :inquiries
  has_many_attached :images

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :drafts, -> { where(draft: true) }

  validate :must_have_photo_to_publish

  before_update :change_draft

  def main_photo
    return images.first if main_image_id.blank?
    images.where(id: main_image_id).first
  end

  def check_photo_count
    update(published: false) if images.count.none?
  end

  def blobs
    return @blobs if @blobs
    blob_ids = images.pluck :blob_id
    @blobs = ActiveStorage::Blob.where(id: blob_ids)
  end

  def image_selection
    images.map { |attach| [attach.blob.filename.to_s, attach.id] }
  end

  private

  def change_draft
    return if !draft or !published
    self.draft = false
  end

  def must_have_photo_to_publish
    if published_changed? and published and main_photo.blank?
      errors.add(:published, :no_photo, message: 'requires at least one photo')
    end
  end
end
