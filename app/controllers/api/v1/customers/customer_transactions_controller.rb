class Api::V1::Customers::CustomerTransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Customer.find(params[:customer_id]).transactions)
  end
end
