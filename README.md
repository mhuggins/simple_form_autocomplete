# SimpleFormAutocomplete

`simple_form_autocomplete` is a Ruby gem that enables use of [jQuery
Autocomplete](http://jqueryui.com/autocomplete/) inputs with
[SimpleForm](https://github.com/plataformatec/simple_form).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_form_autocomplete'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_form_autocomplete

## Usage

Require the Javascript in your `application.js` (or other preferred) file via sprockets:

```javascript
//= require 'simple_form_autocomplete'
```

Alternatively import the CSS in your `application.css.scss` (or other preferred) file.  For
sprockets-based apps:

```javascript
//= require 'simple_form_autocomplete';
```

For SCSS imports:

```javascript
@import 'simple_form_autocomplete';
```

When rendering form via SimpleForm's `simple_form_for` method, supply the new input via the `:as`
option along with a `:source` option to specify the data source URL or array of objects:

```ruby
simple_form_for @ingredient do |f|
  f.input :name, as: :autocomplete, source: autocomplete_ingredients_path
  f.input :unit, as: :autocomplete, source: ['cup', 'tablespoon', 'teaspoon']
  f.input :quantity
end
```

The value supplied for the `:source` option should match the format expected per the [jQuery
autocomplete documentation](http://api.jqueryui.com/autocomplete/#option-source).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
