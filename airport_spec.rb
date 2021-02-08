require 'airport'
require 'plane'

describe Airport do
    #let(:plane) { double :plane }
    let(:airport) { Airport.new(weather, 30) }
    let(:plane) { Plane.new } 
    let(:weather) { Weather.new }
    #let(:default_airport) { Airport.new(weather) }

    describe '#land' do
        before do
            allow(weather).to receive(:stormy?).and_return false
        end
        it "lands a plane at an airport" do
            expect(airport) .to respond_to :land
        end 

        it "does not let plane land when capacity is full" do
            30.times do 
                airport.land(plane)
            end 
            expect { airport.land(plane) }.to raise_error 'Capacity is full : Cannot land plane'
        end
    end

    describe '#planes' do

        before do
            allow(weather).to receive(:stormy?).and_return false
        end

        it "returns planes at the airport" do
            airport.land(plane)
            expect(airport.planes).to include plane
        end
    end


    describe '#capacity' do 
        it 'sets default capacity for airports' do
            default_airport = Airport.new(Weather.new)
            Airport::DEFAULT_CAPACITY.times { default_airport.land(plane) }
            allow(weather).to receive(:stormy?).and_return false
            expect { default_airport.land(plane) }.to raise_error 'Capacity is full : Cannot land plane'
        end
    end
 
    describe'#take_off' do
        it "instructs a plane to take off" do
            expect { airport.take_off(plane) }.not_to raise_error
        end

        it 'confirms plane has left the airport' do
            airport.land(plane)
            airport.take_off(plane)
            expect(airport.planes).not_to include plane
        end
    end

    describe '#weather' do
        before do
            allow(weather).to receive(:stormy?).and_return true
        end
        it "does not allow planes to land when stormy" do
            expect { airport.land(plane) }.to raise_error 'Weather is stormy : Cannot land plane'
        end

        it "does not allow planes to take off when stormy" do 
            expect { airport.take_off(plane) }.to raise_error 'Weather is stormy : Plane cannot take off'
        end
    end


end 