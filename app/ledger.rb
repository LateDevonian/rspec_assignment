require 'byebug'
require_relative '../config/sequel'

module ExpenseTracker
  #package status information in a record class
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  class Ledger
    def record(expense)
      unless expense.key?('payee')
        message = "Invalid expense: 'payee' is required"
        return RecordResult.new(false, nil, message)
      end
      unless expense.key?('amount')
        message = "Invalid expense: 'amount' is required"
        return RecordResult.new(false, nil, message)
      end
      unless expense.key?('date')
        message = "Invalid expense: 'date' is required"
        return RecordResult.new(false, nil, message)
      end

      # original, works, just in case i fuckitup
      #unless expense.key?('payee')
      #   message = "Invalid expense: 'payee' is required"
      #   return RecordResult.new(false, nil, message)
      # end




      DB[:expenses].insert(expense)
      id = DB[:expenses].max(:id)
      RecordResult.new(true, id, nil)
    end

    def expenses_on(date)
      DB[:expenses].where(date: date).all
    end
  end
end
