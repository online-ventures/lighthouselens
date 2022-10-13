module ItemsHelper
  def pretty_price(price)
    return "$#{number_with_delimiter(price, delimiter: ',')}" if price.to_i.positive?

    'Call for pricing'
  end
end
