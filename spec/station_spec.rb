require 'station'

describe Station do
  let(:name) { double :name }
  let(:zone_number) { double :zone }
  let(:subject) { Station.new(name, zone_number) }

  describe '#name' do
    it 'returns the name' do
        expect(subject.name).to eq name
    end
  end


  describe '#zone' do
    it 'returns the zone number' do
        expect(subject.zone).to eq zone_number
    end
  end
end