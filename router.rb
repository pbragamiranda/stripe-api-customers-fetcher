require "stripe"

class Router
  def initialize(customers_controller)
    @running = true
    @stripe_api_key = ask_and_verify_api_key
    @customers_controller = customers_controller
  end

  def run
    print `clear`
    welcome_message
    while @running
      print_menu
      choice = gets.chomp.to_i
      print `clear`
      route_action(choice)
    end
  end

  private

  def print_menu
    puts "-------------- menu --------------"
    puts "1. Download all your customers"
    puts "2. Download next 50 customers"
    puts "3. Display all your customers"
    puts "4. Display number of custumers"
    puts "9. Exit"
    print "> "
  end

  def welcome_message
    puts "Stripe api successfully validated. Welcome!" 
  end

  def route_action(choice)
    case choice
    when 1 then @customers_controller.download_customers(@stripe_api_key)
    when 2 then @customers_controller.download_customers(@stripe_api_key, quantity: 50)
    when 3 then @customers_controller.list_customers
    when 4 then @customers_controller.count_customers
    when 9 then stop!
    else puts "Wrong input. Try again..."
    end
  end

  def stop!
    @running = false
  end

  def ask_and_verify_api_key
    api_key = ask_for_stripe_api_key
    Stripe.api_key = api_key
    begin
      Stripe::Customer.create
      api_key
    rescue
      puts "Invalid api key."
      ask_and_verify_api_key
    end
  end

  def ask_for_stripe_api_key
    puts "Please provide a valid stripe api key:"
    print "> "
    gets.chomp
  end
end
