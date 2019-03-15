require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
  end

  describe 'instance methods' do
    before :each do
      @date = '2019-03-12 19:31:18 UTC'
      @assertion = '2019-03-12T19:31:18.000Z'
      @merchant = create(:merchant)
      @invoice = create(:invoice, merchant: @merchant, created_at: @date, updated_at: @date)
      @invoice_2 = create(:invoice, merchant: @merchant)
      @invoice_3 = create(:invoice, merchant: @merchant)
      create(:transaction, invoice: @invoice)
      create(:transaction, invoice: @invoice_2, result: 'failed')
      create(:transaction, invoice: @invoice_3)
      create_list(:invoice_item, 5, invoice: @invoice)
      create_list(:invoice_item, 5, invoice: @invoice_2)
      create_list(:invoice_item, 5, invoice: @invoice_3)
    end
    describe 'total_revenue' do
      it 'returns the total revenue for a merchant across successful transactions' do
        expect(@merchant.total_revenue[0].revenue).to eq(1000000)
      end
    end

    describe 'total_revenue_date' do
      it 'returns the total revenue for a merchant across successful transactions on a specific date' do
        expect(@merchant.total_date_revenue('2019-03-12')[0].revenue).to eq(500000)
      end
    end
  end
end
