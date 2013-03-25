module Atheme::Authenticate
  attr_accessor :user

  def login(username, password)
    call('atheme.login', username, password)
  end

  def logout(token, username)
    call('atheme.logout', token, username)
  end
end
