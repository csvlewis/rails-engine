class Api::V1::Items::ItemsSearchController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.where(item_params))
  end

  def show
    render json: ItemSerializer.new(Item.find_by(item_params))
  end

  private

  def item_params
    params.permit(:id, :name, :unit_price, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
