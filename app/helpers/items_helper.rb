module ItemsHelper
  def pretty_price(price)
    "$#{number_with_delimiter(price, delimiter: ',')}"
  end
end
