module Atheme
  SERVICES = []
end

require 'xmlrpc/client'
require 'atheme/version'
require 'atheme/configuration'
require 'atheme/authenticate'
require 'atheme/service'
require 'atheme/objectified_hash'

Dir[File.expand_path('../atheme/services/*.rb', __FILE__)].each { |file| require file }

module Atheme
  extend Configuration
  extend Authenticate

  def self.server
    XMLRPC::Client.new2("#{Atheme.url}:#{Atheme.port}/xmlrpc")
  end

  def self.call(*args)
    server.call(*args)
  end

  def self.set_user(cookie, username, ip)
    self.user = Atheme::ObjectifiedHash.new({ cookie: cookie, username: username, ip: ip })
  end
end
