class Order < ActiveRecord::Base
  has_one :merchant
  has_one :purchaser
  has_one :item
  has_one :invoice

  validates_presence_of :quantity

  def self.create_order_and_associations(hashed_order)
    purchaser = Purchaser.find_or_create_by(name: hashed_order['purchaser name'])
    item = Item.where(description: hashed_order["item description"], price: hashed_order["item price"].to_i).first_or_create!
    merchant = Merchant.where(address: hashed_order["merchant address"], name: hashed_order["merchant name"].to_i).first_or_create!

    self.create!(quantity: hashed_order["purchase count"], purchaser_id: purchaser.id, merchant_id: merchant.id, item_id: item.id)
  end
end