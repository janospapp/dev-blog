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
require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) { build(:post) }

  describe 'validations' do
    context 'when published' do
      subject(:post) { build(:post, :published) }

      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:summary) }
      it { is_expected.to validate_presence_of(:body) }
    end

    context 'when not published' do
      it { is_expected.not_to validate_presence_of(:title) }
      it { is_expected.not_to validate_presence_of(:summary) }
      it { is_expected.not_to validate_presence_of(:body) }
    end

    it { is_expected.to validate_numericality_of(:visitor_count).is_greater_than_or_equal_to(0) }

    it 'must be published in the past' do
      post.published_at = 3.hours.from_now
      post.valid?
      expect(post.errors.messages[:published_at]).to include(/cannot be in the future/)
    end

    describe ':ref' do
      # For these specs the post must be persisted, otherwise 'ref' is generated
      subject(:post) { create(:post) }

      it { is_expected.to validate_presence_of(:ref) }
      it { is_expected.to validate_uniqueness_of(:ref) }
    end
  end

  describe '#published' do
    subject(:posts) { Post.published }

    let!(:published_post) { create(:post, :published) }
    let!(:unpublished_post) { create(:post) }

    it { is_expected.to eq([published_post]) }
  end

  describe '#published?' do
    subject(:post) { build(:post, published_at: published_at).published? }

    context 'when published' do
      let(:published_at) { Time.current }

      it { is_expected.to be true }
    end

    context 'when not published' do
      let(:published_at) { nil }

      it { is_expected.to be false }
    end
  end

  describe '#publish' do
    it 'sets published time' do
      expect { post.publish }.to change(post, :published?).from(false).to(true)
    end
  end

  describe '#unpublish' do
    subject(:post) { build(:post, :published) }

    it 'removes published time' do
      expect { post.unpublish }.to change(post, :published?).from(true).to(false)
    end
  end

  describe '#visited!' do
    subject(:post) { build(:post, visitor_count: 4) }

    it 'increases the counter' do
      expect { post.visited! }.to change(post, :visitor_count).from(4).to(5)
    end
  end

  describe 'body_updated_at' do
    subject(:post) { build(:post, body: nil, body_updated_at: 3.days.ago) }

    before { freeze_time }

    context 'when the body does not change' do
      it 'keeps the body_updated_at the same' do
        expect { post.update(title: 'Updated title') }.not_to change(post, :body_updated_at)
      end
    end

    context 'when the body is updated' do
      it 'updates the body_updated_at attribute' do
        expect { post.update(body: 'New body') }
          .to change(post, :body_updated_at).from(3.days.ago).to(Time.current)
      end
    end
  end
end
