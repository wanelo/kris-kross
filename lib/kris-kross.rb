require "kris-kross/version"
require "kris-kross/configuration"
require "kris-kross/handler"

module Kris
  class Kross
    # Does Kris live inside Kross, or does Kross live inside Kris?
    # This is like a crazy X-Files episode!

    def self.configure(&block)
      Kris::Kross::Configuration.instance.configure(&block)
    end

    def initialize(app)
      Kris::Kross::Handler.instance.app = app
    end

    def call(env)
      Kris::Kross::Handler.instance.call(env)
    end
  end
end

require "kris-kross/railtie" if defined? Rails
