module Atheme
  SERVICES = []
  PARSERS  = {}
end

require 'xmlrpc/client'
require 'atheme/version'
require 'atheme/errors'
require 'atheme/configuration'
require 'atheme/authenticate'
require 'atheme/objectified_hash'
require 'atheme/support'
require 'atheme/parser'
require 'atheme/parser_helper'

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
    XMLRPC::Client.new2("#{Atheme.options.protocol}://#{Atheme.options.hostname}:#{Atheme.options.port}/xmlrpc")
  end

  def self.call(*args)
    server.call(*args)
  end

  def self.set_user(cookie, username, ip)
    self.user = Atheme::ObjectifiedHash.new({ cookie: cookie, username: username, ip: ip })
  end
end
