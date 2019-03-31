class Application

  @@items = []
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    case req.path
    when /cart/
      if @@cart.empty? #responds with empty cart message if the cart is empty
        resp.write "Your cart is empty"
      else #responds with a cart list if there is something in there
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    when /add/
      item_to_add = req.params["item"]

      if @@items.include?(item_to_add)
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      else
        resp.write "We don't have that item"
      end
    end
    resp.finish
  end
end
