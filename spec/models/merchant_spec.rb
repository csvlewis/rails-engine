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
    describe 'total_revenue' do
      before :each do
        @merchant = create(:merchant)
        @invoice = create(:invoice, merchant: @merchant)
        @invoice_2 = create(:invoice, merchant: @merchant)
        create(:transaction, invoice: @invoice)
        create(:transaction, invoice: @invoice_2, result: 'failed' )
        create_list(:invoice_item, 5, invoice: @invoice)
        create_list(:invoice_item, 5, invoice: @invoice_2)
      end

      it 'returns the total revenue for a merchant across successful transactions' do
        expect(@merchant.total_revenue[0].revenue).to eq(500000)
      end
    end
  end
end
