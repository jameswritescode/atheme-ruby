module Atheme
  SERVICES = []
end

require 'xmlrpc/client'
require 'atheme/version'
require 'atheme/errors'
require 'atheme/configuration'
require 'atheme/authenticate'
require 'atheme/objectified_hash'
require 'atheme/parser'

Dir[File.expand_path('../atheme/parsers/*.rb', __FILE__)].each { |file| require file }

require 'atheme/service'

module Atheme
  extend Configuration
  extend Authenticate

  %w(ALIS ChanServ GameServ Global GroupServ HelpServ HostServ InfoServ MemoServ NickServ OperServ RPGServ StatServ).each do |name|
    module_eval <<-RUBY
      class Atheme::#{name} < Atheme::Service
      end
    RUBY
  end

  def self.server
    XMLRPC::Client.new2("#{Atheme.protocol}://#{Atheme.hostname}:#{Atheme.port}/xmlrpc")
  end

  def self.call(*args)
    server.call(*args)
  end

  def self.set_user(cookie, username, ip)
    self.user = Atheme::ObjectifiedHash.new({ cookie: cookie, username: username, ip: ip })
  end

  def self.constantize(camel_cased_word)
    names = camel_cased_word.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object

    names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end

    constant
  end
end
