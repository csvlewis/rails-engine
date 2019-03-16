class Api::V1::Transactions::TransactionInvoiceController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Transaction.find(params[:transaction_id]).invoice)
  end
end
