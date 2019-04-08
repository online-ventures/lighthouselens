module ItemsHelper
  def pretty_price(price)
    return "$#{number_with_delimiter(price, delimiter: ',')}" if price > 0
    'Call for pricing'
  end
end
