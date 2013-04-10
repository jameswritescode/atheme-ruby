class Atheme::Service
  include Atheme::Parser

  attr_reader :to_raw

  def initialize(output)
    @to_raw = output
  end

  def self.inherited(klass)
    Atheme::SERVICES << klass.name.gsub('Atheme::', '')
  end

  def self.create_service_object(method, service, atheme_data)
    begin
      self.new(atheme_data).extend(Atheme.constantize("Atheme::Parser::#{service}::#{method.capitalize}"))
    rescue
      self.new(atheme_data)
    end
  end

  def self.method_missing(method, *args, &block)
    raise Atheme::Error::NoUserSet, 'No user has been set' if Atheme.user.nil?

    service = self.name.gsub('Atheme::', '')

    self.create_service_object(method, service, Atheme.call('atheme.command',
      Atheme.user.cookie, Atheme.user.username, Atheme.user.ip,
      service, method, *args))
  end
end
