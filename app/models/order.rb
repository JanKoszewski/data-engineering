class Order < ActiveRecord::Base
  has_one :merchant
  has_one :purchaser
  has_one :item
  has_one :invoice

  validates_presence_of :quantity
end