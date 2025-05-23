# frozen_string_literal: true

require_relative 'lib/yard/readme/version'
require_relative 'lib/yard/readme/description'

Gem::Specification.new do |spec|
  spec.name = "yard-readme"
  spec.version = YARD::Readme::VERSION
  spec.authors = ["Matt Ruzicka"]
  spec.license = "MIT"

  spec.summary = "YARD plugin for the readme_yard gem"
  spec.description = YARD::Readme::DESCRIPTION
  spec.homepage = 'https://github.com/mattruzicka/yard-readme'
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency 'irb'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
