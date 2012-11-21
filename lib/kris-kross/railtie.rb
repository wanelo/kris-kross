module Kris
  class Kross
    class Railtie < Rails::Railtie
      initializer "kriss_kross.insert_middleware" do |app|
        app.config.middleware.use "Kris::Kross"
      end
    end
  end
end
