class Invoice < ActiveRecord::Base
  serialize :order_ids

  has_many :orders

  def self.create_and_store(invoice_file)
    invoice = new(filename: invoice_file.original_filename)

    invoice.create_parsed_file(invoice_file)
    invoice.create_hashed_orders!
    invoice.create_orders!
  end

  def create_parsed_file(invoice_file)
    @parsed_file = CSV.parse(invoice_file.read)
  end

  def create_hashed_orders!
    headers = @parsed_file[0].first.split("\t")
    orders = @parsed_file[1..-1].map! do |order|
      order.first.split("\t")
    end

    @hashed_orders = orders.collect do |order|
      Hash[headers.zip order]
    end
  end

  def create_orders!
    @hashed_orders.each do |order|
      Order.create_order_and_associations(order)
    end
  end

end