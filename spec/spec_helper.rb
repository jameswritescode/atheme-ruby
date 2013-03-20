require 'rspec'
require 'pry'
require 'atheme'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |file| require file }

def atheme_config
  YAML.load_file(File.expand_path('../config.yml', __FILE__))
end

def configure_atheme
  Atheme.configure do |config|
    config.port = atheme_config['port']
    config.url = atheme_config['url']
  end
end

def authenticate
  cookie = Atheme.login(atheme_config['nick'], atheme_config['password'])

  Atheme.set_user(cookie, atheme_config['nick'], atheme_config['ip'])
end

RSpec.configure do |config|
  config.before(:each) { configure_atheme }
end
