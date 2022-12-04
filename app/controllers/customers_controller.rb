require_relative "../models/customer"
require_relative "../views/customers_view"
require_relative "../services/stripe_customers_fetcher"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list_customers
    customers = @customer_repository.all
    @customers_view.display(customers)
  end

  def count_customers
    number_of_customers = @customer_repository.all.count
    @customers_view.display_number_of_customers(number_of_customers)
  end

  def download_customers(stripe_api_key, quantity: "all")
    last_customer = @customer_repository.all.last
    customers_from_stripe = StripeCustomersFetcher.new(stripe_api_key).call(last_customer)
    @customer_repository.create_customers(customers_from_stripe, quantity)
    @customers_view.successful_message
  end
end
