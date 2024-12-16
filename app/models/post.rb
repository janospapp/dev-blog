class Post < ApplicationRecord
  before_create :generate_ref
  before_save :handle_body_change

  scope :published, -> { where.not(published_at: nil) }

  def published?
    published_at.present?
  end

  def publish!
    update(published_at: Time.current)
  end

  def unpublish!
    update(published_at: nil)
  end

  def visited!
    increment!(:visitor_count)
  end

  private

  def generate_ref
    self.ref ||= Random.hex(16)
  end

  def handle_body_change
    return unless body_changed?

    self.body_updated_at = Time.current
  end
end
