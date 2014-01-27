class Item < ActiveRecord::Base
  has_many :orders

  validates_presence_of :price
  validates_presence_of :description
end