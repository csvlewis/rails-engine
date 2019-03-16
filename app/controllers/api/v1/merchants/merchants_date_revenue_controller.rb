class Api::V1::Merchants::MerchantsDateRevenueController < ApplicationController
  def show
    render json: TotalRevenueSerializer.new(Merchant.date_revenue(params[:date])[0])
  end
end
