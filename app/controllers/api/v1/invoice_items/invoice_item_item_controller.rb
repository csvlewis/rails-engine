class Api::V1::InvoiceItems::InvoiceItemItemController < ApplicationController
  def show
    render json: ItemSerializer.new(InvoiceItem.find(params[:invoice_item_id]).item)
  end
end
