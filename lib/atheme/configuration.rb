module Atheme::Configuration
  attr_accessor :hostname, :port, :protocol

  def configure
    self.protocol ||= 'http'

    yield self
  end
end
