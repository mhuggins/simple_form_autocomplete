class Ingredient
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :id, :name, :unit

  def persisted?
    false
  end
end
