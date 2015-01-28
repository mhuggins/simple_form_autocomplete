require 'spec_helper'

describe SimpleForm::Inputs::AutocompleteInput do
  let(:controller) { MockController.new }

  describe '#input' do
    subject { Nokogiri::HTML(form) }

    let(:record) { Ingredient.new }
    let(:collection) { %w[cup teaspoon tablespoon] }
    let(:form_options) { {} }
    let(:options) { {} }
    let(:form) do
      concat(simple_form_for(record, form_options) { |f|
        concat(f.input :name, { as: :autocomplete, source: ingredients_autocomplete_path }.merge(options))
        concat(f.input :unit, { as: :autocomplete, source: collection }.merge(options))
      })
    end

    describe 'with default options' do
      it 'should set the default label class' do
        label = subject.xpath('//label[@for="ingredient_name"]')
        expect(label.attribute('class').value).to match /\bautocomplete\b/
      end

      it 'should set the default input class' do
        input = subject.xpath('//input[@id="ingredient_name_autocomplete"]')
        expect(input.attribute('class').value).to match /\bautocomplete\b/
      end

      it 'should set the source url' do
        input = subject.xpath('//input[@id="ingredient_name_autocomplete"]')
        expect(input.attribute('data-source').value).to eq ingredients_autocomplete_path
      end

      it 'should set the source json' do
        input = subject.xpath('//input[@id="ingredient_unit_autocomplete"]')
        expect(input.attribute('data-source').value).to eq CGI.escape_element(collection.to_json)
      end

      it 'should render a hidden input' do
        input = subject.xpath('//input[@id="ingredient_name"]')
        expect(input.attribute('type').value).to eq 'hidden'
      end
    end

    describe 'with custom options' do
      let(:options) do
        {
            input_html: { id: 'baz', class: 'completer', data: { foo: 'bar' } },
            label_html: { class: 'completer-label', data: { lorem: 'ipsem' } },
        }
      end

      it 'should set the custom label class' do
        label = subject.xpath('//label[@for="baz"]')
        expect(label.attribute('class').value).to match /\bcompleter-label\b/
      end

      it 'should set the custom label data attribute' do
        label = subject.xpath('//label[@for="baz"]')
        expect(label.attribute('data-lorem').value).to match /\bipsem\b/
      end

      it 'should set the custom input class' do
        input = subject.xpath('//input[@id="baz"]')
        expect(input.attribute('class').value).to match /\bcompleter\b/
      end

      it 'should set the custom input id' do
        input = subject.xpath('//input[@id="baz"]')
        expect(input.attribute('id').value).to eq 'baz'
      end

      it 'should set the custom input data attribute' do
        input = subject.xpath('//input[@id="baz"]')
        expect(input.attribute('data-foo').value).to eq 'bar'
      end

      it 'should set the custom input data attribute' do
        input = subject.xpath('//input[@id="baz"]')
        expect(input.attribute('data-foo').value).to eq 'bar'
      end

      it 'should maintain the input source data attribute' do
        input = subject.xpath('//input[@id="baz"]')
        expect(input.attribute('data-source').value).to eq ingredients_autocomplete_path
      end
    end

    describe 'with wrapper options' do
      before do
        SimpleForm.setup do |config|
          config.wrappers :custom, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
            b.use :html5
            b.use :placeholder
            b.optional :maxlength
            b.optional :pattern
            b.optional :min_max
            b.optional :readonly
            b.use :label, class: 'control-label'

            b.use :input, class: 'form-control'
            b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
            b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
          end
        end
      end

      let(:form_options) { { wrapper: :custom } }

      it 'should maintain the custom wrapper class' do
        div = subject.xpath('//div[contains(concat(" ", normalize-space(@class), " "), "ingredient_name")]')
        expect(div.attribute('class').value).to match /\bform-group\b/
      end

      it 'should maintain the custom input class' do
        input = subject.xpath('//input[@id="ingredient_name_autocomplete"]')
        expect(input.attribute('class').value).to match /\bform-control\b/
      end
    end
  end
end
