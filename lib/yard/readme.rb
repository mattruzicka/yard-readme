# frozen_string_literal: true

require_relative "readme/version"
require_relative "readme/description"
require_relative "readme/docstring_parser"
require_relative "readme/tag_factory"

module YARD
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
