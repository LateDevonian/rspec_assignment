require 'sinatra/base'
require 'json'
require_relative 'ledger'
require 'byebug'
require 'ox'
require 'pry'

module ExpenseTracker
  class API < Sinatra::Base

    #on POST request, api class tells ledger to record the expense
    def initialize(ledger: Ledger.new)
      @ledger = ledger
      super()
    end

    def parse_expense(request)
			case request.media_type
				when 'text/xml'
					nil
				when 'application/json', 'application/x-www-form-urlencoded', ''
					JSON.parse(request.body.read)
				else
					nil
			end
    end


    #add a post route to sinatra app
    post '/expenses' do
      #status 404
      # initial code to just return any shit, superceeded JSON.generate('expense_id' => 42)
      #expense = JSON.parse(request.body.read)
      expense = parse_expense(request)
      result = @ledger.record(expense)
      #add in error handling code to return true or false
      if result.success?
        JSON.generate('expense_id' => result.expense_id)
      else
        status 422
        JSON.generate('error' => result.error_message)
      end
    end

      #add a get route to the sinatra app
      #return empty array to start with

    get '/expenses/:date' do
      JSON.generate(@ledger.expenses_on(params[:date]))
    end
  end
end
