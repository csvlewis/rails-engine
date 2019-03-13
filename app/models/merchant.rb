class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  def total_revenue
    invoices.joins(:transactions, :invoice_items)
            .where(transactions: { result: 'success' })
            .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
