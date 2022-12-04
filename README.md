# Stripe Customers Download App

Download Stripe customers `:id`, `:name`, `:email`, `:account_balance`, and `:default_currency` into a CSV file.


## Usage
Run `app.rb` file and insert your Stripe API key.

```bash
ruby app.rb

Please provide a valid Stripe API key:
>
```
Press 1, 2, 3, 4 or 9 for one of the available actions.
```
Stripe API successfully validated. Welcome!
-------------- menu --------------
1. Download all your customers
2. Download next 50 customers
3. Display all your customers
4. Display number of custumers
9. Exit
>
```

## Testing
To be able to run the testing files, please update the `:stripe_api_key` variable in files `spec/integration/user_actions.rb` and `spec/services/stripe_customers_fetcher.rb`

```ruby
let(:stripe_api_key) { "your_stripe_api_key" }
```
