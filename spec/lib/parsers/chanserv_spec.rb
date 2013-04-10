require 'spec_helper'

describe Atheme::Parser::ChanServ do
  context '.info' do
    before { authenticate }

    let(:info) { Atheme::ChanServ.info atheme_config['channel'] }

    it 'has a founder' do
      expect(info.founder).to eql 'newton'
    end

    it 'has a successor' do
      expect(info.successor).to eql 'robert'
    end

    it 'should have a registered date' do
      info.stub(:registered).and_return(Date.today.to_time)

      expect(info.registered).to eql Date.today.to_time
    end
  end
end
