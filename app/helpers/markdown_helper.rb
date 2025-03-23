module MarkdownHelper
  def md(text)
    markdown.render(text).html_safe
  end

  private

  def markdown
    @markdown ||= Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
  end

  class CustomRenderer < Redcarpet::Render::HTML
    def header(header, header_level)
      case header_level
      when 1
        %(<h1 class="my-5 text-5xl">#{header}</h1>)
      when 2
        %(<h2 class="my-3 text-4xl">#{header}</h2>)
      else
        super
      end
    end

    def block_code(code, language)
      %(<pre class="
          my-5 border-solid border-2 border-nord8 rounded-md shadow-md
          shadow-nord8"
        ><code class="language-#{language}">#{code}</code></pre>)
    end

    def codespan(code)
      %(<code class="text-nord9">#{code}</code>)
    end

    def link(link, title, content)
      %(<a href="#{link}" target="_blank" class="
          border-r border-b px-2 ml-px hover:border hover:border-nord8
          hover:m-0"
        >#{content}</a>)
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
