require 'spec_helper'

describe Atheme::Configuration do
  it 'should have a port' do
    expect(Atheme.options.port).to eql atheme_config['port']
  end

  it 'should have a url' do
    expect(Atheme.options.hostname).to eql atheme_config['hostname']
  end

  it 'should have a protocol' do
    expect(Atheme.options.protocol).to eql atheme_config['protocol']
  end
end
