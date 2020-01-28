class Oystercard
  attr_reader :balance
  attr_accessor :in_journey

  MAXIMUM_BALANCE = 90  

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Balance of #{MAXIMUM_BALANCE} exceeded." if (amount + balance) > MAXIMUM_BALANCE
    @balance += amount
  end 

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    @in_journey = false
  end
end
