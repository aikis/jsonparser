require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "save product" do
    products(:one).save
    assert !products(:two).save, "Save duplicated data!"
  end
end
