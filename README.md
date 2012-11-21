Kris::Kross
===========

Kris Kross will make you jump jump between domains with cross origin requests. Have you read
that RFC? It's F-en crazy! What headers do you set where, and who do you tell what to make those
requests actually go through?

This gem will totally kross out your confusion, and you'll be left young, rich and dangerous with
your programming gold.

## Installation

Add this line to your application's Gemfile:

    gem 'kris-kross'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kris-kross

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
