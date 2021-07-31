# yard-readme

A YARD plugin used by [readme_yard](https://github.com/mattruzicka/readme_yard). It adds the `@readme` tag to YARD.

It also replaces the default `YARD::DocstringParser` so that only the the `@readme` tag name, not its text, is stripped from the generated documentation. I prefer this over the default YARD behavior for this particular tag because it allows the comments in the source code to signal the README dependency without pushing the generated YARD documentation into a separate "readme" section. That said, I would welcome a PR that adds the default behavior as an option, as I think it could be preferable for some use cases.

Ideally, I or someone would open a YARD PR to make leaving the tag text an option when registering a tag. This plugin's current behavior of replacing the `YARD::DocstringParser` could potentially conflict with other YARD plugins and is also more vulnerable to change.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattruzicka/yard-readme.
