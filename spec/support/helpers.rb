module AutocompleteSpecHelper
  include ActionDispatch::Routing::UrlFor
  include ActionController::RecordIdentifier if defined?(ActionController::RecordIdentifier)
  include ActionView::RecordIdentifier if defined?(ActionView::RecordIdentifier)
  include ActionView::Helpers::FormHelper
  include SimpleForm::ActionViewExtensions::FormHelper

  def self.included(base)
    base.class_eval do
      attr_writer :output_buffer

      def output_buffer
        @output_buffer ||= ActionView::OutputBuffer.new
      end

      def protect_against_forgery?
        false
      end
    end
  end

  def ingredients_path(*)
    '/ingredients'
  end

  def ingredients_autocomplete_path
    '/ingredients/autocomplete'
  end
end
