# Atheme Ruby

[![Code Climate](https://codeclimate.com/github/zaphyous/atheme-ruby.png)](https://codeclimate.com/github/zaphyous/atheme-ruby) [![Dependency Status](https://gemnasium.com/zaphyous/atheme-ruby.png)](https://gemnasium.com/zaphyous/atheme-ruby)

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

To see supported services [go here](https://github.com/zaphyous/atheme-ruby/blob/feature/chanserv_methods/lib/atheme.rb#L21).

If you use a custom service you can create a class like so:

```ruby
class Atheme::ServiceName < Atheme::Service
end
```

Each command will return an object of the `Atheme::Service` that is used. All will always have `#to_raw` that has the raw services output.

Some commands will return an object with additional methods on them depending if a parser exists for that command. [Parsers can be seen here](https://github.com/zaphyous/atheme-ruby/tree/develop/lib/atheme/parsers)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create new Pull Request
