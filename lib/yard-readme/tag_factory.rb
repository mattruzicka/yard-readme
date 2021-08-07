module YARDReadme
  class TagFactory < YARD::Tags::Library.default_factory.class
    #
    # @see https://github.com/lsegal/yard/blob/359006641260eef1fe6d28f5c43c7c98d40f257d/lib/yard/tags/default_factory.rb#L70
    #
    def parse_tag_with_title_and_text(tag_name, text)
      return YARD::Tags::Tag.new(tag_name, text) if blank_readme_tag?(tag_name, text)

      super
    end

    def blank_readme_tag?(tag_name, text)
      tag_name == "readme" && text.nil? || text.empty?
    end
  end
end
