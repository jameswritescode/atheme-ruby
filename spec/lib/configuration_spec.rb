require 'spec_helper'

describe Atheme::Configuration do
  it 'should have a port' do
    expect(Atheme.options.port).to eql 1234
  end

  it 'should have a url' do
    expect(Atheme.options.hostname).to eql 'localhost'
  end

  it 'should have a protocol' do
    expect(Atheme.options.protocol).to eql 'http'
  end

  it 'should raise an error if configuration is missing required options' do
    expect { Atheme.configure hostname: 'example.com' }.to raise_error Atheme::Error::InvalidConfiguration
    expect { Atheme.configure port: 1234 }.to raise_error Atheme::Error::InvalidConfiguration
    expect(Atheme.configure hostname: 'example.com', port: 1234).to be_a Hash
  end
end
