require 'spec_helper'

describe 'Atheme::Service' do
  it 'should have services' do
    expect(Atheme::SERVICES.count).to be > 0
  end

  it 'should be able to query services' do
    authenticate

    expect(Atheme::ChanServ.help).to be_true
  end
end
