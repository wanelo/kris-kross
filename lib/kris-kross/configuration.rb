require 'singleton'

module Kris
  class Kross
    class Configuration
      include Singleton

      attr_writer :origins, :headers

      def configure
        yield self
        self
      end

      def origins(hostnames = nil)
        if hostnames.nil?
          [@origins].flatten
        else
          @origins = hostnames
        end
      end

      def headers(headers = nil)
        if headers.nil?
          (default_headers + [@headers]).flatten.compact.join(' ')
        else
          @headers = headers
        end
      end

      def self.origins
        @origins ||= self.instance.origins
      end

      def self.hosts
        @hosts ||= origins.join(' ')
      end

      def self.headers
        @headers ||= self.instance.headers
      end

      private

      def default_headers
        %w{X-Requested-With X-Prototype-Version Authorization Authentication}
      end
    end
  end
end
