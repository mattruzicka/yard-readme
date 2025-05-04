## [0.5.0] - 2025-05-04

- Extracted description into separate file `lib/yard/readme/description.rb`
- Updated documentation to use this centralized description in gemspec and README
- Updated tag examples from `@readme object` to `@readme code` to reflect readme_yard updates
- Updated README

## [0.4.0] - 2025-05-03

### Breaking Changes
- Changed module namespace from `YARDReadme` to `YARD::Readme` for better integration with YARD's namespace
- Moved files from `lib/yard-readme/` to `lib/yard/readme/` to match the new namespace structure
- Increased minimum required Ruby version from 2.4.0 to 3.0.0

### Features
- Improved documentation with comprehensive explanations of how custom readme tags work
- Added example for `YARD::Readme::DocstringParser.readme_tag_names` to demonstrate usage
- Enhanced docstring comments with detailed API documentation
- Updated YARD plugin to better integrate with readme_yard 0.3.0+

### Documentation Updates
- Restructured README with clear sections explaining the plugin's functionality
- Added detailed documentation for each component of the plugin:
  - Custom Readme Tag Support
  - Tag Processing functionality
  - Tag Method descriptions
  - Readme Text Processing explanations

### Dependencies
- Updated YARD dependency from `~> 0.9.26` to `~> 0.9` to support newer versions
- Removed specific readme_yard development dependency, now integrates with any compatible version

## [0.3.0] - 2021-08-07

- Rename newly added methods be373f150e865b933a58a950e6a5c654395e17c4

## [0.2.0] - 2021-08-07

- Be able to support new readme tag args in readme_yard without updating this gem b76ad2459168e4361ab38912e6faa7e36f249cec

## [0.1.2] - 2021-08-07

- Inherit from existing default to minimize conflict between plugins 69463cb2f580a1f5bcb734564eb51b32bf833250
- Avoid raising error when readme tag text is blank 294c9400de41d297c71212939b410e4ce821bc15
- Remove special readme tag names (README_YARD args) from docs when parsing docstring 983e1485b89888d390dc4879e7019fd7785dedda

## [0.1.1] - 2021-07-31

- Use readme_yard to build README

## [0.1.0] - 2021-07-25

- Initial release
