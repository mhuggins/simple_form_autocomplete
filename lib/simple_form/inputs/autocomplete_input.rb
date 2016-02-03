require 'active_support/core_ext/hash/deep_merge'

module SimpleForm
  module Inputs
    class AutocompleteInput < Base
      def input(wrapper_options = nil)
        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

        @builder.text_field(attribute_name, merged_input_options) <<
            @builder.hidden_field(attribute_name, hidden_html_options)
      end

      private

      def input_html_options
        super.deep_merge(
            name:  "#{object_name}[#{attribute_name }_label]",
            id:    options.key?(:input_html) && options[:input_html].key?(:id) ? options[:input_html][:id] : input_tag_id,
            value: options.key?(:value) ? options[:value] : input_tag_value,
            data:  { source: options[:source] }
        )
      end

      def hidden_html_options
        {
            value: options.key?(:value) ? options[:value] : hidden_tag_value
        }
      end

      def input_tag_id
        "#{sanitized_object_name}_#{sanitized_attribute_name}_autocomplete"
      end

      def input_tag_value
        return unless association

        if association.respond_to?(:label)
          association.label
        elsif association.respond_to?(:title)
          association.title
        elsif association.respond_to?(:name)
          association.name
        else
          association.to_s
        end
      end

      def hidden_tag_value
        if association
          if respond_to?(:id)
            association.id
          else
            association.to_s
          end
        end
      end

      def sanitized_object_name
        @sanitized_object_name ||= object_name.to_s.gsub(/\]\[|[^-a-zA-Z0-9:.]/, '_').sub(/_$/, '')
      end

      def sanitized_attribute_name
        @sanitized_method_name ||= attribute_name.to_s.sub(/\?$/, '')
      end

      def association
        @association ||= begin
          association_name = attribute_name.to_s
          association_name.gsub!(/_id\z/, '')
          @builder.object.send(association_name.to_sym)
        end
      end
    end
  end
end
