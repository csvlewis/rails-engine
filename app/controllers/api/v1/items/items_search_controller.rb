class Api::V1::Items::ItemsSearchController < ApplicationController
  def index
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].tr('.', '').to_i
      render json: ItemSerializer.new(Item.where(unit_price: params[:unit_price]))
    else
      render json: ItemSerializer.new(Item.where(item_params))
    end
  end

  def show
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].tr('.', '').to_i
      render json: ItemSerializer.new(Item.find_by(unit_price: params[:unit_price]))
    else
      render json: ItemSerializer.new(Item.find_by(item_params))
    end
  end

  private

  def item_params
    params.permit(:id, :name, :unit_price, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
