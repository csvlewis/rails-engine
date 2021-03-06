class Api::V1::Invoices::InvoiceTransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Invoice.find(params[:invoice_id]).transactions)
  end
end
