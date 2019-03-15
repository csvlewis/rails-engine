class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

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

  def favorite_customer
    customers.select('customers.*, transactions.count AS count')
             .joins(invoices: :transactions)
             .merge(Transaction.successful)
             .group(:id)
             .order('count DESC')
             .limit(1)
  end

  def self.most_revenue(number)
    joins(invoices: [:transactions, :invoice_items])
      .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
      .merge(Transaction.successful)
      .group(:id)
      .order('revenue DESC')
      .limit(number)
  end
end
