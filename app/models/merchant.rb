class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  def total_revenue
    invoices.select('sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
            .joins(:transactions, :invoice_items)
            .merge(Transaction.successful)
  end

  def total_date_revenue(date)
    invoices.select('sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
            .joins(:transactions, :invoice_items)
            .merge(Transaction.successful)
            .where("DATE(invoices.created_at) = ?", date)
  end
end
