class Api::V1::Invoices::InvoicesRandomController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.all.sample)
  end
end
