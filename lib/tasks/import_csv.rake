require 'csv'

namespace :import do
  task :csv => :environment do

    csv_text = File.read('data/customers.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end

    puts 'Imported Customers'

    csv_text = File.read('data/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end

    puts 'Imported Merchants'

    csv_text = File.read('data/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end

    puts 'Imported Invoices'

    csv_text = File.read('data/items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end

    puts 'Imported Items'

    csv_text = File.read('data/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end

    puts 'Imported InvoiceItems'

    csv_text = File.read('data/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end

    puts 'Imported Transactions'
  end
end
