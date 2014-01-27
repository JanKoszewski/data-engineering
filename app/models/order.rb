class Order < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :purchaser
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :quantity

  def self.create_order_and_associations(hashed_order, invoice_id)
    purchaser = Purchaser.find_or_create_by(name: hashed_order['purchaser name'])
    item = Item.where(description: hashed_order["item description"], price: hashed_order["item price"].to_i).first_or_create!
    merchant = Merchant.where(address: hashed_order["merchant address"], name: hashed_order["merchant name"].to_i).first_or_create!

    self.create!(
      quantity: hashed_order["purchase count"].to_i,
      purchaser_id: purchaser.id,
      merchant_id: merchant.id,
      item_id: item.id,
      invoice_id: invoice_id)
  end

  def revenue
    (self.item.price * self.quantity).to_i
  end
end