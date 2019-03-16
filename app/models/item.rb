class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order(:id) }

  def self.most_revenue(limit)
    self.unscoped.joins(invoices: :transactions)
      .select('items.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
      .merge(Transaction.successful)
      .group(:id)
      .order('revenue DESC')
      .limit(limit)
  end

  def self.most_items(limit)
    self.unscoped.joins(invoices: :transactions)
      .select('items.*, sum(invoice_items.quantity) as quantity_sold')
      .merge(Transaction.successful)
      .group(:id)
      .order('quantity_sold DESC')
      .limit(limit)
  end

  def best_day
    invoices.joins(:invoice_items, :transactions)
            .select('DATE(invoices.created_at) as best_day, sum(invoice_items.quantity) as amount_sold')
            .merge(Transaction.successful)
            .group('best_day')
            .order('amount_sold DESC')
            .limit(1)
  end
end
