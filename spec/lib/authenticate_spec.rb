require 'spec_helper'

describe Atheme::Authenticate do
  it 'should get a cookie when logging in' do
    expect(Atheme.login(atheme_config['nick'], atheme_config['password'])).to match(/([a-z]){20}/)
  end

  it 'should get a XMLRPC::FaultException when incorrect login information is provided' do
    expect { Atheme.login(atheme_config['nick'], 'bad-password') }.to raise_error XMLRPC::FaultException
  end

  it 'should remember a user when set' do
    cookie = Atheme.login(atheme_config['nick'], atheme_config['password'])

    Atheme.set_user(cookie, atheme_config['nick'], atheme_config['ip'])

    expect(Atheme.user.cookie).to eql cookie
    expect(Atheme.user.username).to eql atheme_config['nick']
  end
end
