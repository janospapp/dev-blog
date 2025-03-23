require 'rails_helper'

RSpec.describe "admin/posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      create(
        :post,
        :published,
        title: "Title",
        summary: "MySummary",
        body: "MyBody",
        visitor_count: 2
      ),
      create(
        :post,
        title: "Title",
        summary: "MySummary",
        body: "MyBody",
        visitor_count: 2
      )
    ])
  end

  it "renders a list of posts" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title"), count: 2
    assert_select cell_selector, text: Regexp.new("MySummary"), count: 2
    assert_select cell_selector, text: Regexp.new("MyBody"), count: 0
    assert_select 'button', text: Regexp.new("Unpublish"), count: 1
    assert_select 'button', text: Regexp.new("Publish"), count: 1
  end

  it "renders the new post button" do
    render
    expect(rendered).to include('New post')
  end
end
