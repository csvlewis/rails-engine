class Api::V1::Invoices::InvoicesSearchController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.where(invoice_params))
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find_by(invoice_params))
  end

  private

  def invoice_params
    params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
  end
end
