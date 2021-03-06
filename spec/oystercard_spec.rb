describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey){ {a: entry_station, b: exit_station} }

  describe '#initialize' do
    it 'defaults balance to 0' do
      expect(subject.balance).to eq 0
    end
    it '#journeys to nil' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#top_up' do 
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'adds money to the card' do
      expect { subject.top_up(30) }.to change{ subject.balance }.by 30
    end

    it 'has a balance limit of £90 upon initialization' do
      expect(described_class::MAXIMUM_BALANCE).to eq 90
    end

    it 'raises an error if the balance exceeds the limit' do
      max_balance = described_class::MAXIMUM_BALANCE
      subject.top_up(max_balance)
      expect{ subject.top_up(1) }.to raise_error "Balance of #{max_balance} exceeded." 
    end
  end

  it 'has a minimum fare' do
    expect(Oystercard::MINIMUM_FARE).to eq 1
  end

  describe "#touch_in(start)" do
    it { is_expected.to respond_to(:touch_in) }

    it 'changes in_journey to true' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      expect(subject.touch_in(entry_station)).to be_truthy
    end

    it "can touch in" do
      subject.top_up(2)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'will not touch in if below minimum balance' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient balance to touch in"
    end
  end

  describe "#in_journey?" do
    it { is_expected.to respond_to(:in_journey?) }

    it 'returns false at the start' do
      expect(subject.in_journey?).to be false
    end

    it 'returns true when the user has touched in' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to be true
    end

    it 'returns false when the user has touched out' do
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to be false
    end
  end

  describe "#touch_out" do
    before(:each) do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(exit_station)
    end
    it { is_expected.to respond_to(:touch_out) }

    it 'changes in_journey to false' do
      expect { subject.touch_out(exit_station) }.to change{ subject.in_journey?}.to false
    end

    it 'can touch out' do
      subject.touch_out(exit_station)
      expect(subject).to_not be_in_journey
    end

    it 'deducts the minimum fare from the balance at touch out' do
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by -Oystercard::MINIMUM_FARE
    end

    it 'removes the entry station' do
      subject.touch_out(exit_station)
      expect(subject.entry_station).to be_nil
    end

    it 'adds a journey' do
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.journeys }
        .by([journey])
      expect(subject.journeys).to include(journey)
    end
  end

  describe "#entry_station" do
    it "returns entry station" do
      subject.top_up(described_class::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end
  end

  describe '#journeys' do
    it 'returns journey list array' do
      expect(subject.journeys).to be_an(Array)
    end
  end
end 

