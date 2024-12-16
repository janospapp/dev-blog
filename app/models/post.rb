# == Schema Information
#
# Table name: posts
#
#  id              :bigint           not null, primary key
#  body            :text
#  body_updated_at :datetime
#  published_at    :datetime
#  ref             :string           not null
#  summary         :text
#  title           :string
#  visitor_count   :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_posts_on_published_at  (published_at)
#  index_posts_on_ref           (ref) UNIQUE
#
class Post < ApplicationRecord
  before_validation :generate_ref, unless: :persisted?
  before_save :handle_body_change

  scope :published, -> { where.not(published_at: nil) }

  validates :title, :summary, :body, presence: true, if: :published?
  validates :ref, presence: true, uniqueness: true
  validates :visitor_count, numericality: { greater_than_or_equal_to: 0 }

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
