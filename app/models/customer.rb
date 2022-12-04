# frozen_string_literal: true

class Customer
  attr_reader :id, :name, :email, :account_balance, :default_currency

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @email = attributes[:email]
    @account_balance = attributes[:account_balance]
    @default_currency = attributes[:default_currency]
  end
end
