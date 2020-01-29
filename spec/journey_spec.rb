require 'journey'

describe Journey do
    describe "#fare" do
        it 'responds to the fare method' do
         expect(subject).to respond_to(:fare)
        end    
    end
end