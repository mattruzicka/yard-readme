# frozen_string_literal: true

require_relative "readme/version"
require_relative "readme/docstring_parser"
require_relative "readme/tag_factory"

module YARD
  #
  # @readme
  #   A [YARD](https://yardoc.org) plugin used by
  #   [readme_yard](https://github.com/mattruzicka/readme_yard).
  #   It adds a `@readme` tag to YARD.
  #
  #   It also replaces the default docstring parser so that only
  #   `@readme` tags and not their text values are stripped from
  #   the generated documentation. I prefer this over the default
  #   YARD behavior for the `@readme` tag because it allows the
  #   comments in the source code to signal the README dependency
  #   without pushing the generated YARD documentation into a
  #   separate "readme" section.
  #
  module Readme
    #
    # @see https://www.rubydoc.info/gems/yard/0.9.13/YARD/DocstringParser
    #
    YARD::Docstring.default_parser = YARD::Readme::DocstringParser

    #
    # @see https://www.rubydoc.info/gems/yard/file/docs/TagsArch.md
    #
    YARD::Tags::Library.default_factory = YARD::Readme::TagFactory

    YARD::Tags::Library.define_tag('README', :readme, :with_title_and_text)
  end
end
