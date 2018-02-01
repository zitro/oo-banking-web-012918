require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount=50)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    # sender & receiver
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if  self.valid? && @status == 'pending' && @amount < sender.balance
      # binding.pry
      sender.balance -= self.amount
      receiver.balance += self.amount
      @status = 'complete'
    else
      @status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if  self.valid? && @status == 'complete' && @amount < receiver.balance
      # binding.pry
      sender.balance += self.amount
      receiver.balance -= self.amount
      @status = 'reversed'
    else
      @status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end
end
