require 'pry'
class Transfer
  # your code here
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    # binding.pry
    # p self
    if self.valid? && @status == "pending" && @sender.balance > @amount
      @sender.balance = @sender.balance - @amount
      @receiver.deposit(@amount)
      @status = "complete"
    else
      reject_transfer
    end
    
  end

  def reverse_transfer
    if @status == "complete"
      @receiver.balance = @receiver.balance - @amount
      @sender.deposit(@amount)
      @status = "reversed"
    end
  end
  
  def reject_transfer
    @status = "rejected"
    "Transaction rejected. Please check your account balance."
  end
end
