# yard-readme

A [YARD](https://yardoc.org) plugin used by
[readme_yard](https://github.com/mattruzicka/readme_yard).
It adds a `@readme` tag to YARD.

It also replaces the default docstring parser so that only
`@readme` tags and not their text values are stripped from
the generated documentation. I prefer this over the default
YARD behavior for the `@readme` tag because it allows the
comments in the source code to signal the README dependency
without pushing the generated YARD documentation into a
separate "readme" section.

That said, I welcome a PR that adds the default behavior as an option, as I think it could be preferable for some use cases. Ideally, I or someone would open a YARD PR to make leaving
the tag text an option when registering a tag. Especially
since this plugin's current behavior of replacing the
`YARD::DocstringParser` could potentially conflict with
other YARD plugins and is also more vulnerable to change.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattruzicka/yard-readme.
