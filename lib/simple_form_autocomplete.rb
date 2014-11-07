require 'simple_form_autocomplete/version'
require 'simple_form/inputs/autocomplete_input'

module SimpleFormAutocomplete
  class << self
    def load!
      register_rails_engine if rails?
    end

    private

    def register_rails_engine
      require_relative 'simple_form_autocomplete/engine'
    end

    def rails?
      defined?(::Rails)
    end
  end
end

SimpleFormAutocomplete.load!
