require 'rack/test'
require 'json'
require_relative '../../app/api'

module ExpenseTracker
  RSpec.describe 'Expense Tracker API', :db do
    include Rack::Test::Methods

    def app
      ExpenseTracker::API.new
    end
    #method to post the expense to the webpage /expenses in JSON format
    def post_expense(expense)
      post '/expenses', JSON.generate(expense)
      #check the post attempt was a success
      expect(last_response.status).to eq(200)

      #check the data is in JSON structure
      parsed = JSON.parse(last_response.body)

      #check the data includes an expense_id
      #passing a matcher into another = composing matchers
      expect(parsed).to include('expense_id' => a_kind_of(Integer))

      #add an id key to the hash
      expense.merge('id' => parsed['expense_id'])
    end


    #set up the data to test, run this every time
    it 'records submitted expenses' do
        coffee = post_expense(
        'payee' => "Starbucks",
        'amount' => 5.75,
        'date' => '2017-06-10'
      )
      zoo = post_expense(
        'payee' => "Zoo",
        'amount' => 15.25,
        'date' => '2017-06-10'
      )
      groceries = post_expense(
        'payee' => "Whole Foods",
        'amount' => 95.20,
        'date' => '2017-06-11'
      )
      #get all exppenses posted on a certain date
      get '/expenses/2017-06-10'
      #check that JSON returns
      expect(last_response.status).to eq(200)
      #put the last response into expense
      expenses = JSON.parse(last_response.body)
      #check the expected expenses are there
      expect(expenses).to contain_exactly(coffee, zoo)
    end
  end
end
