class Atheme::Service
  include Atheme::Parser

  attr_reader :to_raw

  def initialize(command, output)
    @command = command
    @to_raw = output
  end

  def self.inherited(klass)
    Atheme::SERVICES << klass.name.gsub('Atheme::', '')
  end

  def self.create_service_object(method, atheme_data)
    begin
      self.new(method, atheme_data).extend(Atheme.constantize("Atheme::Parser::ChanServ::#{method.capitalize}"))
    rescue
      self.new(method, atheme_data)
    end
  end

  def self.method_missing(method, *args, &block)
    raise Atheme::NoUserSetError, 'No user has been set' if Atheme.user.nil?

    self.create_service_object(method, Atheme.call('atheme.command',
      Atheme.user.cookie, Atheme.user.username, Atheme.user.ip,
      self.name.gsub('Atheme::', ''), method, *args))
  end
end
