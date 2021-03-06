# Atheme Ruby

[![Gem Version](https://badge.fury.io/rb/atheme.png)](http://badge.fury.io/rb/atheme) [![Code Climate](https://codeclimate.com/github/jameswritescode/atheme-ruby.png)](https://codeclimate.com/github/jameswritescode/atheme-ruby) [![Dependency Status](https://gemnasium.com/jameswritescode/atheme-ruby.png)](https://gemnasium.com/jameswritescode/atheme-ruby)

A ruby way to access the [Atheme IRC Services](http://www.atheme.net) XMLRPC interface.

## Installation

Add this line to your application's Gemfile:

    gem 'atheme'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install atheme

## Usage

### Requirements

You need to be using [Atheme IRC Services](http://www.atheme.net) with httpd and XMLRPC enabled.

### Configuration

```ruby
Atheme.configure hostname: 'example.com', port: 1234, protocol: 'http'
```

Optional: `protocol` (default http)

### Authentication

```ruby
cookie = Atheme.login('nickname', 'password') # Returns an authcookie

Atheme.set_user(cookie, 'nickname', 'ip.add.re.ss') # Sets the users info for commands
```

### Services commands

```ruby
Atheme::ChanServ.info '#channel'
Atheme::NickServ.set 'email', 'james@example.com'
```

Any command can be used that the user has access to use.

Command format: `Atheme::ServiceName.command 'param', 'param', ...`

To see supported services [go here](https://github.com/jameswritescode/atheme-ruby/blob/master/lib/atheme.rb#L24).

Each command will return an object of the `Atheme::Service` that is used. All will always have `#raw_services_output` that has the raw services output.

Some commands will return an object with additional methods on them depending if a parser exists for that command. [Parsers can be seen here](https://github.com/jameswritescode/atheme-ruby/tree/master/lib/atheme/parsers)

## Testing

In order to be able to generate VCR cassettes properly when testing (minus those that already exist!) you must run a local IRC server with Atheme with httpd and XMLRPC enabled (listening on `localhost:1234`).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create new Pull Request
