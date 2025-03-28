require 'rails_helper'

RSpec.describe "admin/posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      title: "MyString",
      summary: "MyText",
      body: "MyText",
      visitor_count: 1
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", admin_posts_path, "post" do
      assert_select "input[name=?]", "post[title]"

      assert_select "textarea[name=?]", "post[summary]"

      assert_select "textarea[name=?]", "post[body]"
    end
  end
end
