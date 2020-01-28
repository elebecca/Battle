describe Oystercard do
  it 'initializes with a default balance of 0' do
    expect(subject.balance).to eq 0
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

  describe "#deduct" do
    it 'deducts an amount from the balance' do
      subject.top_up(20)
      expect{ subject.deduct 3 }.to change{ subject.balance }.by -3
    end
  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in).with(0).argument }

    it 'changes in_journey to true' do
      expect(subject.touch_in).to be true
    end

    it "can touch in" do
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe "#in_journey?" do
    it { is_expected.to respond_to(:in_journey?).with(0).argument }

    it 'returns false at the start' do
      expect(subject.in_journey?).to eq false
    end

    it 'returns true when the user has touched in' do
      subject.touch_in
      expect(subject.in_journey?).to be true
    end

    it 'returns false when the user has touched out' do
      subject.touch_out
      expect(subject.in_journey?).to be false
    end
  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out).with(0).argument }

    it 'changes in_journey to false' do
      subject.touch_in
      expect(subject.touch_out).to be false
    end
  end

end 

