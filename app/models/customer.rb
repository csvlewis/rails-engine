class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants.select('merchants.*, transactions.count AS transaction_count')
             .joins(invoices: :transactions)
             .merge(Transaction.successful)
             .group(:id)
             .order('transaction_count DESC')
             .limit(1)
  end
end
