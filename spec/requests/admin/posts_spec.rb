require 'rails_helper'

RSpec.describe "/admin/posts", type: :request do
  let(:valid_attributes) do
    {
      title: 'Original Title',
      summary: 'Original Summary',
      body: 'Original Body'
    }
  end
  let(:invalid_attributes) do
    {
      title: '',
      summary: ''
    }
  end
  let(:new_attributes) do
    {
      title: 'New Title',
      summary: 'New Summary',
      body: 'New Body'
    }
  end

  let(:record) { create(:post, **valid_attributes) }

  context "when no admin is logged in" do
    describe "GET /index" do
      it "redirects to the login page" do
        get admin_posts_url
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "GET /show" do
      it "redirects to the login page" do
        get admin_post_url(record)
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "GET /new" do
      it "redirects to the login page" do
        get new_admin_post_url
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "GET /edit" do
      it "redirects to the login page" do
        get edit_admin_post_url(record)
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "POST /create" do
      it "does not create a new Post" do
        expect {
          post admin_posts_url, params: { post: valid_attributes }
        }.not_to change(Post, :count)
      end

      it "redirects to the login page" do
        post admin_posts_url, params: { post: valid_attributes }
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "PATCH /update" do
      it "does not update the requested post" do
        patch admin_post_url(record), params: { post: new_attributes }
        expect(record.reload.title).to eq('Original Title')
      end

      it "redirects to the login page" do
        patch admin_post_url(record), params: { post: new_attributes }
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "DELETE /destroy" do
      it "does not destroy the requested post" do
        record
        expect {
          delete admin_post_url(record)
        }.not_to change(Post, :count)
      end

      it "redirects to the login page" do
        delete admin_post_url(record)
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "PATCH /publish" do
      let(:record) { create(:post) }

      it "does not update the requested post" do
        patch publish_admin_post_url(record)
        expect(record.reload).not_to be_published
      end

      it "redirects to the login page" do
        patch publish_admin_post_url(record)
        expect(response).to redirect_to('/auth/admin/login')
      end
    end

    describe "PATCH /unpublish" do
      let(:record) { create(:post, :published) }

      it "does not update the requested post" do
        patch unpublish_admin_post_url(record)
        expect(record.reload).to be_published
      end

      it "redirects to the login page" do
        patch unpublish_admin_post_url(record)
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

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Post" do
          expect {
            post admin_posts_url, params: { post: valid_attributes }
          }.to change(Post, :count).by(1)
        end

        it "redirects to the created post" do
          post admin_posts_url, params: { post: valid_attributes }
          expect(response).to redirect_to(admin_post_url(Post.last))
        end
      end
    end

    describe "PATCH /update" do
      let(:record) { create(:post, :published, **valid_attributes) }

      context "with valid parameters" do
        it "updates the requested post" do
          patch admin_post_url(record), params: { post: new_attributes }
          expect(record.reload).to have_attributes(new_attributes)
        end

        it "redirects to the post" do
          patch admin_post_url(record), params: { post: new_attributes }
          expect(response).to redirect_to(admin_post_url(record))
        end
      end

      context "with invalid parameters" do
        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          patch admin_post_url(record), params: { post: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested post" do
        record
        expect {
          delete admin_post_url(record)
        }.to change(Post, :count).by(-1)
      end

      it "redirects to the posts list" do
        delete admin_post_url(record)
        expect(response).to redirect_to(admin_posts_url)
      end
    end

    describe "PATCH /publish" do
      context "when the post is valid" do
        let(:record) { create(:post) }

        it "updates the requested post" do
          patch publish_admin_post_url(record)
          expect(record.reload).to be_published
        end

        it "redirects to posts" do
          patch publish_admin_post_url(record)
          expect(response).to redirect_to(admin_posts_url)
        end
      end

      context "when the post is invalid" do
        let(:record) { create(:post, title: '') }

        it "updates the requested post" do
          patch publish_admin_post_url(record)
          expect(record.reload).not_to be_published
        end

        it "renders the edit page with the error" do
          patch publish_admin_post_url(record)
          assert_template 'admin/posts/edit'
          expect(response.body).to include("Title can&#39;t be blank")
        end
      end

      context "when the post is already published" do
        let(:record) { create(:post, :published) }

        it "keeps the post published" do
          patch publish_admin_post_url(record)
          expect(record.reload).to be_published
        end

        it "redirects to posts" do
          patch publish_admin_post_url(record)
          expect(response).to redirect_to(admin_posts_url)
        end
      end
    end

    describe "PATCH /unpublish" do
      let(:record) { create(:post, :published) }

      it "updates the requested post" do
        patch unpublish_admin_post_url(record)
        expect(record.reload).not_to be_published
      end

      it "redirects to posts" do
        patch unpublish_admin_post_url(record)
        expect(response).to redirect_to(admin_posts_url)
      end

      context "when the post is not published" do
        let(:record) { create(:post) }

        it "keeps the record unpublished" do
          patch unpublish_admin_post_url(record)
          expect(record.reload).not_to be_published
        end

        it "redirects to posts" do
          patch unpublish_admin_post_url(record)
          expect(response).to redirect_to(admin_posts_url)
        end
      end
    end
  end
end
