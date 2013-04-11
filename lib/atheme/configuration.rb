module Atheme::Configuration
  def configure(opts = {})
    required_opts = [:hostname, :port]

    unless opts[:hostname] and opts[:port]
      raise Atheme::Error::InvalidConfiguration, "Missing configuration options: #{required_opts.delete_if { |x| opts.has_key?(x) }}"
    end

    opts[:protocol] ||= 'http'

    @options = opts
  end

  def options
    Atheme::ObjectifiedHash.new(@options)
  end
end
