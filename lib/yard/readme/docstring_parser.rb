module YARD
  module Readme
    #
    # @readme
    #   This custom DocstringParser extends YARD's default parser to provide
    #   special handling for @readme tags. The main functionality includes:
    #
    #   1. Preserving the text content of @readme tags in the docstring
    #      (instead of moving it to a separate "readme" section)
    #   2. Supporting nested @readme tags with custom names (like @readme comment)
    #   3. Properly handling empty/blank @readme tags
    #
    # This implementation allows source code comments to signal README dependencies
    # without altering how the YARD documentation is organized and displayed.
    #
    class DocstringParser < YARD::Docstring.default_parser
      class << self
        # @readme
        #   Custom readme tag names that should be stripped from the docstring
        #   but preserved in the tag's text. This is used to support the nested tag
        #   feature of readme_yard, where tags like `@readme comment`, `@readme code`,
        #   and `@readme source` control what content gets embedded in the README.
        #
        #   By setting this attribute with an array of tag names (without the "@readme" prefix),
        #   the parser will recognize these as special readme tags and handle them appropriately.
        #
        # @example
        #   YARD::Readme::DocstringParser.readme_tag_names = ["comment", "code", "source"]
        #
        attr_accessor :readme_tag_names

        def readme_tag_names_regex
          @readme_tag_names_regex ||= /\A(#{readme_tag_names.join("|")})/
        end

        def readme_tag_names_regex?
          readme_tag_names && !readme_tag_names.empty?
        end

        def strip_readme_tag_arg(text)
          return text unless readme_tag_names_regex?

          text.sub(readme_tag_names_regex, "")
        end
      end

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

      # @readme
      #   Strips the @readme text of any readme-specific tag names
      #   (as defined in readme_tag_names) and adds appropriate spacing.
      #
      # @param [String] text the raw text from the @readme tag
      # @return [String, nil] the processed text or nil if no processing was done
      #
      def parse_readme_text(text)
        readme_text = self.class.strip_readme_tag_arg(text)
        readme_text << "\n\n" if readme_text
      end

      # @readme
      #   Determines whether a tag's text should be processed as readme text.
      #   Only non-empty @readme tags are processed.
      #
      # @param [String] tag_name the name of the tag
      # @param [String] buf the tag's text buffer
      # @return [Boolean] true if the tag should be processed as readme text
      #
      def parse_readme_text?(tag_name, buf)
        tag_name == 'readme' && !buf.empty?
      end
    end
  end
end