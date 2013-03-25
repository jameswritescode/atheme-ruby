class Atheme::Service
  def self.inherited(base)
    Atheme::SERVICES << base.name.gsub('Atheme::', '')
  end

  def self.method_missing(method, *args, &block)
    Atheme.call('atheme.command', Atheme.user.cookie, Atheme.user.username, Atheme.user.ip, self.name.gsub('Atheme::', ''), method, *args)
  end
end
