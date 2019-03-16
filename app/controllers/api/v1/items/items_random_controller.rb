class Api::V1::Items::ItemsRandomController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.all.sample)
  end
end
