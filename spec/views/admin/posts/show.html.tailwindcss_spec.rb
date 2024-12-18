require 'rails_helper'

RSpec.describe "admin/posts/show", type: :view do
  before(:each) do
    assign(:post, create(
      :post,
      title: "Title",
      summary: "MyText",
      body: "MyText",
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
