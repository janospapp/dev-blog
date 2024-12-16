require 'rails_helper'

RSpec.describe "/posts", type: :request do
  describe "GET /index" do
    before { create_list(:post, 5, :published) }

    it "renders a successful response" do
      get posts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    context 'with a published post' do
      let(:post) { create(:post, :published) }

      it "renders a successful response" do
        get post_url(post)
        expect(response).to be_successful
      end

      it "increases the visitor count" do
        expect { get post_url(post) }.to change { post.reload.visitor_count }.from(1).to(2)
      end
    end

    context 'with an unpublished post' do
      let(:post) { create(:post) }

      it "renders a successful response" do
        get post_url(post)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
