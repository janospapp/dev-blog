require "rails_helper"

RSpec.describe Admin::PostsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/posts").to route_to("admin/posts#index")
    end

    it "routes to #show" do
      expect(get: "/admin/posts/1").to route_to("admin/posts#show", id: "1")
    end

    it "routes to #new" do
      expect(get: "/admin/posts/new").to route_to("admin/posts#new")
    end

    it "routes to #edit" do
      expect(get: "/admin/posts/1/edit").to route_to("admin/posts#edit", id: "1")
    end
    it "routes to #create" do
      expect(post: "/admin/posts").to route_to("admin/posts#create")
    end

    it "routes to #update" do
      expect(patch: "/admin/posts/1").to route_to("admin/posts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/posts/1").to route_to("admin/posts#destroy", id: "1")
    end

    it "routes to #publish" do
      expect(patch: "/admin/posts/1/publish").to route_to("admin/posts#publish", id: "1")
    end

    it "routes to #unpublish" do
      expect(patch: "/admin/posts/1/unpublish").to route_to("admin/posts#unpublish", id: "1")
    end
  end
end
