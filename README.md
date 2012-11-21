Kris::Kross
===========

Kris Kross will make you jump jump between domains with cross origin requests. Have you read
that RFC? It's F-en crazy! What headers do you set where, and who do you tell what to make those
requests actually go through?

This gem will totally kross out your confusion, and you'll be left young, rich and dangerous to
certify your gold-plated programming skills.

## Installation

Add this line to your application's Gemfile:

    gem 'kris-kross'

And then execute:

    $ bundle

## Requirements

This gem is built to work with Rails 3 applications.

## Usage

Including `kris-kross` in a Rails 3 application automatically adds it to the Middleware chain.
Configure it in an initializer:

```ruby
Kris::Kross.configure do |c|
  c.origins %w{ http://my-domain http://my-other-domain}
end
```

The HTTP protocol desired (http/https) should be explicitly set in the configuration block. Kris Kross
makes no assumptions about this.

### Custom Headers

Cors does some extra checking if you send custom headers in your cross origin requests. You can configure
Kris Kross to accept those headers in the following way:

```ruby
Kris::Kross.configure do |c|
  c.origins %w{ http://my-domain}
  c.headers %w{X-Mac-Daddy X-Daddy-Mac}
end
```

These get mixed into a set of default values and returns to clients as `Access-Control-Allow-Headers`.

### Wildcard domains (not!)

Kris Kross can not be configured to open domains to wildcard cross origin requests. Kris Kross is crazy,
but not that crazy.

## Cross Origin Requests explained

Let's say you have a domain `http://make-my-video.com`, from which you serve an amazing javascript-based
video game. With the overwhelming popularity of the site, you are starting to worry that over the weekend
the it may go down.

You move all the logic around saving state to `http://saves.make-my-video.com`, but notice at the last minute
that nothing is making it through to those servers. What are you going to do???

First, you drop `gem kris-kross` into your Gemfile.

Second, you create the file `#{Rails.root}/config/initializers/kris-kross.rb` in
both `make-my-video.com` and `saves.make-my-video.com`:

```ruby
Kris::Kross.configure do |c|
  c.origins %w{ http://make-my-video.com }
end
```

### Client interactions

When a web browser hits your site, the Kris Kross rack middleware will mix in some response headers. You can see
this by hitting your domain with curl:

```bash
> curl http://make-my-video.com -I
HTTP/1.1 200 OK
Server: nginx/1.2.4
Date: Thu, 6 Feb 1992 18:03:07 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 23497
Connection: close
Status: 200 OK
Access-Control-Allow-Origin: http://make-my-video.com
Access-Control-Allow-Credentials: true
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: Wed, 09 Sep 1972 09:09:09 GMT
X-UA-Compatible: IE=Edge
ETag: "7ccdafcac2e2d541fd69823d290126d6"
X-Request-Id: f7c0684f1bc06321039b55d3c431d81b
X-Runtime: 0.762781
```

The browser now knows that you know you have potential cross origin requests, and from where. This is only half
of the picture, though. When the browser tries to do a cross origin request it first tests the crossed domain.
It does this with what is called a preflight check.

Preflight checks hit the cross origin domain with an HTTP call using the OPTIONS verb. Wait, never heard of OPTIONS?
Test it out with another bit of curl:

```bash
> curl -X OPTIONS http://saves.make-my-video.com -I
HTTP/1.1 200 OK
Server: nginx/1.2.4
Date: Thu, 6 Feb 1992 18:09:12 GMT
Transfer-Encoding: chunked
Connection: close
Status: 200 OK
Access-Control-Allow-Origin: http://make-my-video.com
Access-Control-Allow-Methods: POST, GET, OPTIONS
Access-Control-Allow-Headers: X-Requested-With, X-Prototype-Version, Authorization, Authentication
Access-Control-Max-Age: 172800
Access-Control-Allow-Credentials: true
X-UA-Compatible: IE=Edge
Cache-Control: no-cache
X-Request-Id: b287f0b81f5711c659df1caa2d749568
X-Runtime: 0.140053
```

Notice that in these examples, the `Access-Control-Allow-Origin` headers all refer to the main domain,
`make-my-video.com` and not to the cross origin domain.

## References

* http://en.wikipedia.org/wiki/Cross-origin_resource_sharing
* http://www.w3.org/TR/cors/
* https://developer.mozilla.org/en-US/docs/HTTP_access_control

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
