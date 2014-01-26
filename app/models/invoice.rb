class Invoice < ActiveRecord::Base
  serialize :order_ids

  has_many :orders
end