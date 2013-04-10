require 'spec_helper'

describe 'Atheme::Service' do
  it 'should have services' do
    expect(Atheme::SERVICES.count).to be > 0
  end

  it 'should be able to query services' do
    authenticate

    expect(Atheme::ChanServ.help).to be_true
  end

  it 'should error when an invalid services command is used' do
    expect{ Atheme::ChanServ.bad_method }.to raise_error XMLRPC::FaultException
  end

  it 'should have raw xmlrpc output in to_raw' do
    expect(Atheme::ChanServ.help.to_raw).to include('***** ChanServ Help *****')
  end

  it 'should store the command used' do
    expect(Atheme::ChanServ.help.instance_eval('@command')).to eql :help
  end

  it 'should raise an error when no user is set' do
    Atheme.user = nil

    expect { Atheme::ChanServ.help }.to raise_error Atheme::Error::NoUserSet
  end
end
