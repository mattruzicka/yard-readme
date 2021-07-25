module YARDReadme
  class DocstringParser < YARD::DocstringParser
    def parse_content(content)
      content = content.split(/\r?\n/) if content.is_a?(String)
      return '' if !content || content.empty?
      docstring = String.new("")

      indent = content.first[/^\s*/].length
      last_indent = 0
      orig_indent = 0
      directive = false
      last_line = ""
      tag_name = nil
      tag_buf = []

      (content + ['']).each_with_index do |line, index|
        indent = line[/^\s*/].length
        empty = (line =~ /^\s*$/ ? true : false)
        done = content.size == index

        if tag_name && (((indent < orig_indent && !empty) || done ||
            (indent == 0 && !empty)) || (indent <= last_indent && line =~ META_MATCH))
          buf = tag_buf.join("\n")
          if directive || tag_is_directive?(tag_name)
            directive = create_directive(tag_name, buf)
            if directive
              docstring << parse_content(directive.expanded_text).chomp
            end
          else
            push_readme_text(docstring, buf) if tag_name == 'readme'
            create_tag(tag_name, buf)
          end
          tag_name = nil
          tag_buf = []
          directive = false
          orig_indent = 0
        end

        # Found a meta tag
        if line =~ META_MATCH
          directive = $1
          tag_name = $2
          tag_buf = [($3 || '')]
        elsif tag_name && indent >= orig_indent && !empty
          orig_indent = indent if orig_indent == 0
          # Extra data added to the tag on the next line
          last_empty = last_line =~ /^[ \t]*$/ ? true : false

          tag_buf << '' if last_empty
          tag_buf << line.gsub(/^[ \t]{#{orig_indent}}/, '')
        elsif !tag_name
          # Regular docstring text
          docstring << line
          docstring << "\n"
        end

        last_indent = indent
        last_line = line
      end

      docstring
    end

    def push_readme_text(docstring, buf)
      return if buf.empty?

      buf.split("\n").each do |buf_line|
        docstring << buf_line
        docstring << "\n"
      end
      docstring << "\n"
    end
  end
end
