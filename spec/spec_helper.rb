require 'rspec'
require 'pry'
require 'atheme'
require 'vcr'
require 'webmock/rspec'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |file| require file }

def atheme_config
  YAML.load_file(File.expand_path('../config.yml', __FILE__))
end

def configure_atheme
  Atheme.configure port: 1234, hostname: 'localhost'
end

RSpec.configure do |config|
  config.before { configure_atheme }
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
end

def authenticate
  VCR.use_cassette('authenticate_success') do
    cookie = Atheme.login(atheme_config['nick'], atheme_config['password'])

    Atheme.set_user(cookie, atheme_config['nick'], atheme_config['ip'])
  end
end
