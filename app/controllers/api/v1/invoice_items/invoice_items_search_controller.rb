class Api::V1::InvoiceItems::InvoiceItemsSearchController < ApplicationController
  def index
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].tr('.', '').to_i
      render json: InvoiceItemSerializer.new(InvoiceItem.where(unit_price: params[:unit_price]))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_item_params))
    end
  end

  def show
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].tr('.', '').to_i
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(unit_price: params[:unit_price]))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params))
    end
  end

  private

  def invoice_item_params
    params.permit(:id, :quantity, :unit_price, :item_id, :invoice_id, :created_at, :updated_at)
  end
end
