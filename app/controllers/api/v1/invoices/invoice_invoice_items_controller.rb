class Api::V1::Invoices::InvoiceInvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(Invoice.find(params[:invoice_id]).invoice_items)
  end
end
