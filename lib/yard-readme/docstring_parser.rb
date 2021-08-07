module YARDReadme
  #
  # @readme
  #   Ideally, I or someone would open a YARD PR to make leaving
  #   the tag text an option when registering a tag. Especially
  #   since this plugin's current behavior of replacing the
  #   `YARD::DocstringParser` could potentially conflict with
  #   other YARD plugins and is also more vulnerable to change.
  #
  # Doing so would make this custom parser obsolete.
  #
  class DocstringParser < YARD::Docstring.default_parser
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
            readme_text = parse_readme_text(buf) if parse_readme_text?(tag_name, buf)
            docstring << readme_text if readme_text
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

    def parse_readme_text(text)
      readme_text = text.sub(/\A(source|docstring|object)/, "")
      readme_text << "\n\n" if readme_text
    end

    def parse_readme_text?(tag_name, buf)
      tag_name == 'readme' && !buf.empty?
    end
  end
end
