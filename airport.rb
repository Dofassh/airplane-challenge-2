require 'weather'

class Airport 
    DEFAULT_CAPACITY = 30

    def initialize(weather, capacity = DEFAULT_CAPACITY)
    @weather = weather
    @capacity = capacity
    @planes = []
    end
    
    def land(plane)
        raise 'Capacity is full : Cannot land plane' if capacity_full
        raise 'Weather is stormy : Cannot land plane' if stormy?

        @planes << plane
    end

    def take_off(plane)
        raise 'Weather is stormy : Plane cannot take off' if stormy?
        #raise 'plane status : has left the station successfully' if at_airport?(plane)
        plane
    end

    def planes
    
    end

    private 

    def capacity_full
    if @planes.length >= @capacity
    true 
    else false
    end
    end

    def stormy?
    @weather.stormy?
    end

    def at_airport?(plane)
    @planes.include?(plane)
    end

end