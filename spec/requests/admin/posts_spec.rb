require 'rails_helper'

RSpec.describe "/admin/posts", type: :request do
  context "when no admin is logged in" do
    let(:post) { create(:post) }

    describe "GET /index" do
      it "redirects to the login page" do
        get admin_posts_url
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "GET /show" do
      it "redirects to the login page" do
        get admin_post_url(post)
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "GET /new" do
      it "redirects to the login page" do
        get new_admin_post_url(post)
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "GET /edit" do
      it "redirects to the login page" do
        get edit_admin_post_url(post)
        expect(response).to redirect_to('/auth/admin/login')
      end
    end
  end

  context "when an admin is logged in" do
    include_context 'admin logged in'

    let(:record) { create(:post) }

    describe "GET /index" do
      before { create_list(:post, 5, :published) }

      it "renders a successful response" do
        get admin_posts_url
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        get admin_post_url(record)
        expect(response).to be_successful
      end

      it "does not change the visitor count" do
        expect { get admin_post_url(record) }.not_to change { record.reload.visitor_count }
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_admin_post_url
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "renders a successful response" do
        get edit_admin_post_url(record)
        expect(response).to be_successful
      end
    end
  end
end
