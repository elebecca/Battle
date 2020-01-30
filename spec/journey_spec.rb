require 'journey'

describe Journey do
    let(:entry_station) { double :station }
    let(:subject) { Journey.new(entry_station) }


    describe "#initialize" do
        it 'records the entry station' do
            expect(subject.entry_station).to eq entry_station
        end
    end
end