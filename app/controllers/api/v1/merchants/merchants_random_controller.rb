class Api::V1::Merchants::MerchantsRandomController < ApplicationController
  def show
    render json: Merchant.all.sample
  end
end
