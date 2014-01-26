class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.text :order_ids

      t.timestamps
    end
  end
end
