module Atheme::Configuration
  def configure(opts = {})
    opts[:protocol] ||= 'http'

    @options = opts
  end

  def options
    Atheme::ObjectifiedHash.new(@options)
  end
end
