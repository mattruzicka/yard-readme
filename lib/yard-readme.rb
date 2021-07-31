# frozen_string_literal: true

require 'yard'
require_relative 'yard-readme/version'
require_relative 'yard-readme/docstring_parser'

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
module YARDReadme; end

YARD::Docstring.default_parser = YARDReadme::DocstringParser
YARD::Tags::Library.define_tag('README', :readme)
