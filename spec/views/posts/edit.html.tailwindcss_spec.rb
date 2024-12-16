require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  let(:post) {
    Post.create!(
      title: "MyString",
      summary: "MyText",
      body: "MyText",
      visitor_count: 1
    )
  }

  before(:each) do
    assign(:post, post)
  end

  # Fix it when admins will be able to edit
  xit "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(post), "post" do
      assert_select "input[name=?]", "post[title]"

      assert_select "textarea[name=?]", "post[summary]"

      assert_select "textarea[name=?]", "post[body]"

      assert_select "input[name=?]", "post[visitor_count]"
    end
  end
end
