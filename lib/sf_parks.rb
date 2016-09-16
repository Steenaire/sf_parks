require "sf_parks/version"
require "unirest"

module SfParks
  class Park

    attr_reader :name, :address, :type, :service_area, :psa_manager, :psa_email, :psa_phone_number

    def initialize(park)
      @name = park[8].downcase.split.map(&:capitalize).join(' ')

      if park[18][0]
        address = JSON.parse park[18][0].gsub('=>', ':')
        address.each do |header, address_part|
          @address = address_part
        end
      else
        @address = nil
      end

      @type = park[9]
      @service_area = park[10]
      @psa_manager = park[11]
      @psa_email = park[12]
      @psa_phone_number = park[13]

    end

    def self.all
      all_parks_array = Unirest.get("https://data.sfgov.org/api/views/z76i-7s65/rows.json").body["data"]
      parks = []

      all_parks_array.each do |park|
        parks << Park.new(park)
      end
      return parks
    end

    def self.create_foodtrucks(foodtruck_array)

    end

  end
end
