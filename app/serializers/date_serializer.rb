class DateSerializer
  include FastJsonapi::ObjectSerializer
  attribute :best_day do |object|
    object.best_day
  end
  attribute :amount_sold do |object|
    object.amount_sold
  end
end
