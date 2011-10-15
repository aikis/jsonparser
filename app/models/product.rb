class ProductValidator < ActiveModel::Validator
  def validate(record)
    Product.find_each(:name => record.name) do |elem|
      if elem.description == record.description and elem.image == record.image
        record.errors.add "This file is already in datdbase!"
      end
    end
  end
end

class Product < ActiveRecord::Base
  attr_accessible :name, :description, :image
  include ActiveModel::Validations
  validates_with ProductValidator
end