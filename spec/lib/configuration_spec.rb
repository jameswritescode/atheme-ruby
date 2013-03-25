require 'spec_helper'

describe Atheme::Configuration do
  it 'should have a port' do
    expect(Atheme.port).to eql atheme_config['port']
    expect(Atheme.options[:port]).to eql atheme_config['port']
  end

  it 'should have a url' do
    expect(Atheme.url).to eql atheme_config['url']
    expect(Atheme.options[:url]).to eql atheme_config['url']
  end
end
