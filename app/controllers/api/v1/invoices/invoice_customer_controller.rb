class Api::V1::Invoices::InvoiceCustomerController < ApplicationController
  def show
    render json: CustomerSerializer.new(Invoice.find(params[:invoice_id]).customer)
  end
end
