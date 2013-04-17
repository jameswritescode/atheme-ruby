require 'spec_helper'

describe Atheme::Configuration do
  it 'should have a port' do
    expect(Atheme.options.port).to eql 1234
  end

  it 'should have a hostname' do
    expect(Atheme.options.hostname).to eql 'localhost'
  end

  it 'should have a protocol' do
    expect(Atheme.options.protocol).to eql 'http'
  end
end
