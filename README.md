# Atheme Ruby

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
Atheme.configure do |config|
  config.url = 'http://example.com'
  config.port = 9876
end
```

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

To see services supported [go here](https://github.com/zaphyous/atheme-ruby/tree/develop/lib/atheme/services).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create new Pull Request
