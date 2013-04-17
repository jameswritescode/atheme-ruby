module Atheme::Configuration
  REQUIRED_OPTIONS = [:hostname, :port]

  def configure(opts = {})
    unless validate_options(opts)
      raise Atheme::Error::InvalidConfiguration, "Missing configuration options: #{REQUIRED_OPTIONS.delete_if { |x| opts.has_key?(x) }.join(', ')}"
    end

    opts[:protocol] ||= 'http'

    @options = opts
  end

  def options
    Atheme::ObjectifiedHash.new(@options)
  end

  def validate_options(opts)
    REQUIRED_OPTIONS.delete_if { |x| opts.has_key?(x) }.count == 0
  end
end
