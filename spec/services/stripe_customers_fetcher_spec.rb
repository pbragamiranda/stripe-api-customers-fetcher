# frozen_string_literal: true

require_relative '../../app/models/customer'
require_relative '../../app/services/stripe_customers_fetcher'

describe 'Stripe Customer Fetcher', :stripe_customers_fetcher do
  let(:stripe_api_key) { 'your_stripe_api_key' }

  it 'should be initialized with an api key' do
    stripe_customers_fetcher = StripeCustomersFetcher.new(stripe_api_key)
    expect(stripe_customers_fetcher).to be_a(StripeCustomersFetcher)
  end

  describe '#call' do
    it 'should return a Stripe::ListObject' do
      stripe_customers_fetcher = StripeCustomersFetcher.new(stripe_api_key)
      data = stripe_customers_fetcher.call
      expect(data).to be_a(Stripe::ListObject)
    end

    it 'should return 50 results' do
      stripe_customers_fetcher = StripeCustomersFetcher.new(stripe_api_key)
      data = stripe_customers_fetcher.call
      expect(data.count).to eq(50)
    end

    it 'should start downloading customers from last customer downloaded.' do
      stripe_customers_fetcher = StripeCustomersFetcher.new(stripe_api_key)

      first_request = stripe_customers_fetcher.call
      first_customer = Customer.new(id: first_request['data'][0]['id'])
      second_customer = Customer.new(id: first_request['data'][1]['id'])

      second_request = stripe_customers_fetcher.call(first_customer)
      new_first_customer_id = second_request['data'][0]['id']

      expect(second_customer.id).to eq(new_first_customer_id)
    end
  end
end
