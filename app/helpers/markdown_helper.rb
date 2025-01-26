module MarkdownHelper
  def md(text)
    renderer.render(text).html_safe
  end

  private

  def renderer
    @renderer ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      filter_html: true,
      with_toc_data: true,
      prettify: true,
      fenced_code_blocks: true
    )
  end
end
