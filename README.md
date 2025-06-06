# yard-readme

Built for the [readme_yard](https://github.com/mattruzicka/readme_yard) gem as:

A YARD plugin that introduces the @readme tag and powers the readme_yard gem, enabling developers to embed code comments directly into README sections. This eliminates redundancy and keeps documentation consistent across code and project READMEs.

This plugin replaces YARD's default docstring parser with a custom one that handles @readme tags differently. This custom DocstringParser extends YARD's default parser to provide
special handling for @readme tags. The main functionality includes:

1. Preserving the text content of @readme tags in the docstring
   (instead of moving it to a separate "readme" section)
2. Supporting nested @readme tags with custom names (like @readme comment)
3. Properly handling empty/blank @readme tags


## Custom Readme Tag Support

The yard-readme plugin includes support for custom readme tags as used by readme_yard. Custom readme tag names that should be stripped from the docstring
but preserved in the tag's text. This is used to support the nested tag
feature of readme_yard, where tags like `@readme comment`, `@readme code`,
and `@readme source` control what content gets embedded in the README.

By setting this attribute with an array of tag names (without the "@readme" prefix),
the parser will recognize these as special readme tags and handle them appropriately.


```ruby
YARD::Readme::DocstringParser.readme_tag_names = ["comment", "code", "source"]
```


## Tag Processing

The plugin provides custom handling for @readme tags: Custom tag factory that overrides the default YARD tag factory
to provide special handling for @readme tags. Specifically,
it ensures that blank or empty @readme tags are properly processed.


### Tag Methods

The TagFactory includes specialized methods for handling readme tags:

- This method ensures that @readme tags without any text are properly
handled, rather than being processed by the default YARD parser
which expects title and text for tags defined with :with_title_and_text.

- Checks if a tag is a blank @readme tag (no content).
This helper method is used to determine whether special
handling is needed for a given tag.


## Readme Text Processing

The DocstringParser includes specialized methods for processing readme text:

- Determines whether a tag's text should be processed as readme text.
Only non-empty @readme tags are processed.

- Strips the @readme text of any readme-specific tag names
(as defined in readme_tag_names) and adds appropriate spacing.



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattruzicka/yard-readme.
