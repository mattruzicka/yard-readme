# frozen_string_literal: true

require 'yard'
require_relative 'yard-readme/version'
require_relative 'yard-readme/docstring_parser'

YARD::Docstring.default_parser = YARDReadme::DocstringParser
YARD::Tags::Library.define_tag('README', :readme)
