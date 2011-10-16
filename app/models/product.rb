class ProductValidator < ActiveModel::Validator
  def validate(record)
    if p = Product.where(:name => record.name)
      p.each do |elem|
        if elem.description == record.description and elem.image == record.image
          record.errors.add(:name, "This file is already in datdbase!")
        end
      end
    end
  end
end

class Product < ActiveRecord::Base
  attr_accessible :name, :description, :image
  validate :name, :presense => true
  include ActiveModel::Validations
  validates_with ProductValidator
end