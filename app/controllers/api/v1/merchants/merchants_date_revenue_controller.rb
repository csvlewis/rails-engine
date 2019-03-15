class Api::V1::Merchants::MerchantsDateRevenueController < ApplicationController
  def show
    render json: RevenueSerializer.new(Merchant.date_revenue(params[:date]))
  end
end
