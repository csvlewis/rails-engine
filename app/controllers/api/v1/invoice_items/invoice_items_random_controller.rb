class Api::V1::InvoiceItems::InvoiceItemsRandomController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.all.sample)
  end
end
