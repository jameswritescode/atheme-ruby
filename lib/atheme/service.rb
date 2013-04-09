class Atheme::Service
  attr_reader :to_s

  def initialize(command, output)
    @command = command
    @to_s = output
  end

  def self.inherited(klass)
    Atheme::SERVICES << klass.name.gsub('Atheme::', '')
  end

  def self.method_missing(method, *args, &block)
    raise Atheme::NoUserSetError, 'No user has been set' if Atheme.user.nil?

    self.new(method, Atheme.call('atheme.command', Atheme.user.cookie, Atheme.user.username, Atheme.user.ip, self.name.gsub('Atheme::', ''), method, *args))
  end
end
