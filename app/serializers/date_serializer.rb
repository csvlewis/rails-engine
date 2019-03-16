class DateSerializer
  include FastJsonapi::ObjectSerializer
  attribute :date do |object|
    object.best_day
  end
  attribute :amount_sold do |object|
    object.amount_sold
  end
end
