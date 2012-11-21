require 'singleton'

module Kris
  class Kross
    class Configuration
      include Singleton

      attr_writer :origins

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

      def self.origins
        @origins ||= self.instance.origins
      end

      def self.hosts
        @hosts ||= origins.join(' ')
      end
    end
  end
end
