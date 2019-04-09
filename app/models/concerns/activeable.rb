#
# Activeable
#
# Allow a model to be marked active or inactive
#
module Activeable
  extend ActiveSupport::Concern

  included do
    scope :active,   -> { where(deleted_at: nil) }
    scope :inactive, -> { where.not(deleted_at: nil) }
    scope :deleted,  -> { where.not(deleted_at: nil) }
    scope :drafts,   -> { where(draft: true) }

    # Store a list of callbacks to be run when a model is deactivated.
    cattr_accessor :activate_callbacks, :deactivate_callbacks
    self.activate_callbacks = []
    self.deactivate_callbacks = []

    def self.after_deactivate(&block)
      deactivate_callbacks.push(block)
    end

    def self.after_activate(&block)
      activate_callbacks.push(block)
    end

    def active?
      deleted_at.blank?
    end

    def inactive?
      deleted_at.present?
    end

    def deleted?
      inactive?
    end

    def activate
      self.deleted_at = nil
      save unless new_record?
      self.class.activate_callbacks.each do |proc|
        proc.call(self)
      end
    end

    def deactivate
      self.deleted_at = DateTime.now
      save unless new_record?
      self.class.deactivate_callbacks.each do |proc|
        proc.call(self)
      end
    end
  end
end
