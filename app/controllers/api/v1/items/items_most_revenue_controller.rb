class Api::V1::Items::ItemsMostRevenueController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.most_revenue(params[:quantity]))
  end
end
