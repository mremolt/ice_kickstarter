module IceKickstarter
  module Dashboard
    class Developer
      class << self
        def all
          response = JSON.parse(RestClient.get(endpoint))

          response.map do |attributes|
            new(attributes)
          end
        end

        def endpoint
          "#{url}/developers?token=#{token}"
        end

        def url
          Rails.configuration.ice_kickstarter.tenant_api_url
        end

        def token
          Rails.configuration.ice_kickstarter.tenant_api_key
        end
      end

      attr_accessor :perm
      attr_accessor :username

      def initialize(attributes = {})
        attributes.each do |key, value|
          send("#{key}=", value)
        end
      end
    end
  end
end