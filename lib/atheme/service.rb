class Atheme::Service
  attr_reader :raw_services_output

  def initialize(output)
    @raw_services_output = output
  end

  def self.inherited(klass)
    Atheme::SERVICES << klass.name.gsub('Atheme::', '')
  end

  def self.create_service_object(method, service, atheme_data)
    if parser_for?(service, method)
      parser = Atheme::Support.constantize("Atheme::Parser::#{service}::#{method.capitalize}")

      self.new(atheme_data).extend(parser)
    else
      self.new(atheme_data)
    end
  end

  def self.method_missing(method, *args, &block)
    raise Atheme::Error::InvalidUser, 'No user has been set' if Atheme.user.nil?

    service = self.name.gsub('Atheme::', '')

    self.create_service_object(method, service, Atheme.call('atheme.command',
      Atheme.user.cookie, Atheme.user.username, Atheme.user.ip,
      service, method, *args))
  end

  def self.parser_for?(service, command)
    if Atheme::PARSERS.include?(service)
      Atheme::PARSERS[service].include?(command.to_s)
    else
      false
    end
  end
end
