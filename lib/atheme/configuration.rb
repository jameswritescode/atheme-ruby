module Atheme::Configuration
  VALID_CONFIG_OPTIONS = [:url, :port].freeze

  attr_accessor *VALID_CONFIG_OPTIONS

  def configure
    yield self
  end

  def options
    VALID_CONFIG_OPTIONS.inject({}) do |option, key|
      option.merge!(key => send(key))
    end
  end
end
