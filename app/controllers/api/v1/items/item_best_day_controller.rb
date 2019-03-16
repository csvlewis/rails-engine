class Api::V1::Items::ItemBestDayController < ApplicationController
  def show
    render json: DateSerializer.new(Item.find(params[:item_id]).best_day[0])
  end
end
