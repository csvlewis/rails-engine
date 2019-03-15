class Api::V1::Transactions::TransactionsRandomController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.all.sample)
  end
end
