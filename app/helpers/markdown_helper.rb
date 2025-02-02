module MarkdownHelper
  def md(text)
    markdown.render(text).html_safe
  end

  private

  def markdown
    @markdown ||= Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
  end

  class CustomRenderer < Redcarpet::Render::HTML
    def block_code(code, language)
      %(<pre class="
          my-5 border-solid border-2 border-nord8 rounded-md
          shadow-md shadow-nord8"
        ><code class="language-#{language}">#{code}</code></pre>)
    end
  end

  def renderer
    @renderer ||= CustomRenderer.new(
      autolink: true,
      filter_html: true,
      with_toc_data: true
    )
  end
end
