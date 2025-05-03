module YARD
  module Readme
    # @readme
    #   Custom tag factory that overrides the default YARD tag factory
    #   to provide special handling for @readme tags. Specifically,
    #   it ensures that blank or empty @readme tags are properly processed.
    #
    class TagFactory < YARD::Tags::Library.default_factory.class
      #
      # Overrides the default tag parsing behavior to handle blank @readme tags.
      #
      # @param [String] tag_name the name of the tag
      # @param [String] text the tag text
      # @return [YARD::Tags::Tag] the parsed tag
      # @see https://github.com/lsegal/yard/blob/359006641260eef1fe6d28f5c43c7c98d40f257d/lib/yard/tags/default_factory.rb#L70
      #
      # @readme
      #   This method ensures that @readme tags without any text are properly
      #   handled, rather than being processed by the default YARD parser
      #   which expects title and text for tags defined with :with_title_and_text.
      #
      def parse_tag_with_title_and_text(tag_name, text)
        return YARD::Tags::Tag.new(tag_name, text) if blank_readme_tag?(tag_name, text)

        super
      end

      # @readme
      #   Checks if a tag is a blank @readme tag (no content).
      #   This helper method is used to determine whether special
      #   handling is needed for a given tag.
      #
      # @param [String] tag_name the name of the tag
      # @param [String] text the tag text
      # @return [Boolean] true if the tag is a blank readme tag
      #
      def blank_readme_tag?(tag_name, text)
        tag_name == "readme" && text.nil? || text.empty?
      end
    end
  end
end