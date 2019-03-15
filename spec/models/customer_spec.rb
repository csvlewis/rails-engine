require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'instance methods' do
    describe '.favorite_merchant' do
      it 'returns the merchant with whom the customer has conducted the most transactions' do
        customer = create(:customer)
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        create(:merchant)
        invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
        invoice_2 = create(:invoice, merchant: merchant_1, customer: customer)
        invoice_3 = create(:invoice, merchant: merchant_2, customer: customer)
        invoice_4 = create(:invoice, merchant: merchant_2, customer: customer)
        invoice_5 = create(:invoice, merchant: merchant_2, customer: customer)
        create(:transaction, invoice: invoice_1)
        create(:transaction, invoice: invoice_2)
        create(:transaction, invoice: invoice_3)
        create(:transaction, invoice: invoice_4, result: 'failed')
        create(:transaction, invoice: invoice_5, result: 'failed')
        create(:invoice_item, unit_price: 100, quantity: 1, invoice: invoice_1)
        create(:invoice_item, unit_price: 100, quantity: 1, invoice: invoice_2)
        create(:invoice_item, unit_price: 100000, quantity: 1000, invoice: invoice_3)
        create(:invoice_item, unit_price: 100000, quantity: 1000, invoice: invoice_4)
        create(:invoice_item, unit_price: 100000, quantity: 1000, invoice: invoice_5)

        expect(customer.favorite_merchant[0].id).to eq(merchant_1.id)
      end
    end
  end
end
