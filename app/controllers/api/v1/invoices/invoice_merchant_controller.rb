class Api::V1::Invoices::InvoiceMerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Invoice.find(params[:invoice_id]).merchant)
  end
end
