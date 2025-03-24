require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  let(:post) do
    create(
      :post,
      :published,
      title: "Title",
      summary: "MySummary",
      body: "MyBody",
    )
  end

  before do
    assign(:post, post)

    render
  end

  it "renders attributes in <p>" do
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyBody/)
    expect(rendered).not_to match(/MySummary/)
  end

  describe 'Markdown' do
    let(:post) do
      create(
        :post,
        :published,
        title: "Title",
        summary: "MySummary",
        body: <<-BODY
# Summary

This is a post of sample code

```
class Foo; def bar; puts Hello bar end end
```

## Explanation

The above `bar` method prints the string "Hello bar"
        BODY
      )
    end

    it 'renders main headers' do
      expect(rendered).to match(/<h1.*>Summary<\/h1>/)
    end

    it 'renders sub headers' do
      expect(rendered).to match(/<h2.*>Explanation<\/h2>/)
    end

    it 'renders code blocks' do
      expect(rendered).to match(/<pre.*><code.*>class Foo; def bar.*<\/code><\/pre>/m)
    end

    it 'renders inline code' do
      expect(rendered).to match(/<code.*>bar<\/code>/)
    end
  end
end
