require 'spec_helper'

describe Atheme::Parser do
  before do
    module Atheme::Parser::ChanServ
      extend Atheme::Parser
    end
  end

  context '#parse' do
    module Atheme::Parser::ChanServ
      parse :info
    end

    it 'should create a parser module' do
      expect(Atheme::Parser::ChanServ::Info).to be_true
    end

    it 'should create multiple parser modules' do
      module Atheme::Parser::ChanServ
        parse :help
      end

      expect(Atheme::Parser::ChanServ::Info).to be_true
      expect(Atheme::Parser::ChanServ::Help).to be_true
    end
  end

  context '#command' do
    module Atheme::Parser::ChanServ
      parse :info do
        command(:one) { 'one' }
      end
    end

    it 'should create a method on the parser' do
      expect(Atheme::Parser::ChanServ::Info.method_defined?(:one)).to be_true
    end

    it 'should create multiple methods on the parser' do
      module Atheme::Parser::ChanServ
        parse :help do
          command(:one) { 'one' }
          command(:two) { 'two' }
        end
      end

      [:one, :two].each do |method|
        expect(Atheme::Parser::ChanServ::Help.method_defined?(method)).to be_true
      end
    end
  end
end
