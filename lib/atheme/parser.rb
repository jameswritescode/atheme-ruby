module Atheme::Parser
  def self.included(klass)
    if klass.name.split('::').count > 3
      service = klass.name.sub('Atheme::Parser::', '').gsub(/::.*/, '')
      command = klass.name.sub('Atheme::Parser::', '').gsub(/.*::/, '').downcase

      Atheme::PARSERS[service] ||= []

      (Atheme::PARSERS[service] << command) unless command == ''

      Atheme::PARSERS[service].uniq!
    end
  end

  def command(name, &block)
    @commands << [name, block]
  end

  def parse(name)
    @commands = []

    create_parser(name)

    yield if block_given?

    create_commands if @commands.count > 0
  end

  private

  def create_parser(name)
    @parser = "Atheme::Parser::#{self.name.gsub('Atheme::Parser::', '')}::#{name.capitalize}"

    module_eval <<-RUBY
      module #{@parser}
        include Atheme::Parser
        include Atheme::ParserHelper
      end
    RUBY
  end

  def create_commands
    @commands.each do |command, block|
      Atheme::Support.constantize(@parser).send(:define_method, command, block)
    end
  end
end
