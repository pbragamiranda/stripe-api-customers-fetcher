require "csv"
require 'stripe'

Stripe.api_key = 'sk_test_RsUIbMyxLQszELZQEXHTeFA9008YRV7Vhr'

# puts "--"
# def validate_api_key
# 	puts "api_key?"
# 	Stripe.api_key = gets.chomp
# 	begin
# 		puts Stripe::Customer.create
# 	rescue
# 		puts "Invalid ApiKey."
# 		validate_api_key
# 	end
# end


filepath = "data/customers.csv"

# list customers
customers_list = Stripe::Customer.list({limit: 50})
# customers_list = Stripe::Customer.list({limit: 50, starting_after: "cus_MeB0rqwJbhhujG"})
# customers = customers_list["data"]



customers_ids = []
customers_list.auto_paging_each do |customer|
# customers_list.each do |customer|
	customers_ids << customer["id"]
	p customer["id"]
end

p customers_ids.count

# 626












# begin
#   # Use Stripe's library to make requests...
# rescue Stripe::CardError => e
#   puts "Status is: #{e.http_status}"
#   puts "Type is: #{e.error.type}"
#   puts "Charge ID is: #{e.error.charge}"
#   # The following fields are optional
#   puts "Code is: #{e.error.code}" if e.error.code
#   puts "Decline code is: #{e.error.decline_code}" if e.error.decline_code
#   puts "Param is: #{e.error.param}" if e.error.param
#   puts "Message is: #{e.error.message}" if e.error.message
# rescue Stripe::RateLimitError => e
#   # Too many requests made to the API too quickly

# end