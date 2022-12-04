require "stripe"

class StripeCustomersFetcher
  def initialize(api_key)
    @api_key = api_key
    @options = {limit: 50}
  end

  def call(last_customer=nil)
    Stripe.api_key = @api_key
    begin
      @options[:starting_after] = last_customer.id unless last_customer.nil?
      puts "Fetching customers..."
      Stripe::Customer.list(@options)
    rescue Stripe::RateLimitError => e
      puts "RateLimitError. Too many requests made to the API too quickly." 
    end
  end
end