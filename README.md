# Stripe Customers Download App

Terminal interface to download Stripe customers `:id`, `:name`, `:email`, `:account_balance`, and `:default_currency` into a CSV file.


## Usage
Run `app.rb` file and insert your Stripe API key.

```bash
ruby app.rb

Please provide a valid stripe api key:
>
```

## Testing
To be able to run the testing files, please update the `:stripe_api_key` variable in files `spec/integration/user_actions.rb` and `spec/services/stripe_customers_fetcher.rb`

```ruby
let(:stripe_api_key) { "your_stripe_api_key" }
```

