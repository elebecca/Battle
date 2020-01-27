describe Oystercard do
  it 'initializes with a default balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'adds money to the card' do
    expect(subject.top_up(30)).to eq 30
  end
end 


