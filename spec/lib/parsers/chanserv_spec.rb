require 'spec_helper'

describe Atheme::Parser::ChanServ do
  context '.info' do
    before { authenticate }

    let(:info) do
      VCR.use_cassette('chanserv_info') do
        Atheme::ChanServ.info atheme_config['channel']
      end
    end

    it 'has a founder' do
      expect(info.founder).to eql atheme_config['nick']
    end

    it 'has a successor' do
      expect(info.successor).to eql 'username_'
    end

    it 'should have a registered date' do
      expect(info.registered).to eql Date.parse('2013-02-08').to_time
    end
  end
end
