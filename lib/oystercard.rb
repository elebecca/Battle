class Oystercard
  attr_reader :balance, :entry_station, :in_journey, :finish_station

  MAXIMUM_BALANCE = 90  
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @finish_station = "finish_station"
  end

  def top_up(amount)
    raise "Balance of #{MAXIMUM_BALANCE} exceeded." if (amount + balance) > MAXIMUM_BALANCE
    @balance += amount
  end 


  def touch_in(station)
    raise "Insufficient balance to touch in" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  def journeys
    
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
