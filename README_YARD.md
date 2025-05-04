# yard-readme

Built for the [readme_yard](https://github.com/mattruzicka/readme_yard) gem as:

{@readme YARD::Readme::DESCRIPTION}

This plugin replaces YARD's default docstring parser with a custom one that handles @readme tags differently. {@readme YARD::Readme::DocstringParser}

## Custom Readme Tag Support

The yard-readme plugin includes support for custom readme tags as used by readme_yard. {@readme YARD::Readme::DocstringParser.readme_tag_names}

{@example YARD::Readme::DocstringParser.readme_tag_names}

## Tag Processing

The plugin provides custom handling for @readme tags: {@readme YARD::Readme::TagFactory}

### Tag Methods

The TagFactory includes specialized methods for handling readme tags:

- {@readme YARD::Readme::TagFactory#parse_tag_with_title_and_text}
- {@readme YARD::Readme::TagFactory#blank_readme_tag?}

## Readme Text Processing

The DocstringParser includes specialized methods for processing readme text:

- {@readme YARD::Readme::DocstringParser#parse_readme_text?}
- {@readme YARD::Readme::DocstringParser#parse_readme_text}


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattruzicka/yard-readme.
