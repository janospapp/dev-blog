require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      create(
        :post,
        :published,
        title: "Title",
        summary: "MyText",
        body: "MyText",
        visitor_count: 2
      ),
      create(
        :post,
        :published,
        title: "Title",
        summary: "MyText",
        body: "MyText",
        visitor_count: 2
      )
    ])
  end

  it "renders a list of posts" do
    render
    cell_selector = 'div>p'
    assert_select 'h1', text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
