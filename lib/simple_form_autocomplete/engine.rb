module SimpleFormAutocomplete
  module Rails
    class Engine < ::Rails::Engine
      initializer 'simple_form_autocomplete.assets.precompile' do |app|
        %w(stylesheets javascripts).each do |dir|
          app.config.assets.paths << root.join('assets', dir)
        end
      end
    end
  end
end
