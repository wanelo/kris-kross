class Kris::Kross::Handler
  def initialize(app)
    @app = app
  end

  def call(env)
    @env = env

    if options_request?
      [200, option_request_headers, [""]]
    else
      respond(env)
    end
  end

  private

  def option_request_headers
    {
      "Access-Control-Allow-Origin" => Kris::Kross::Configuration.hosts,
      "Access-Control-Allow-Methods" => "POST, GET, OPTIONS",
      "Access-Control-Allow-Headers" => "X-Requested-With, X-Prototype-Version, Authorization, Authentication",
      "Access-Control-Max-Age" => "172800",
      "Access-Control-Allow-Credentials" => 'true'
    }
  end

  def options_request?
    @env["REQUEST_METHOD"] == "OPTIONS"
  end

  def respond(env)
    status, headers, response = @app.call(env)
    [status, headers.merge(cors_headers), response]
  end

  def cors_headers
    {
        "Access-Control-Allow-Origin" => Kris::Kross::Configuration.hosts,
        "Access-Control-Allow-Credentials" => "true"
    }
  end
end
