module Atheme::Parser::ChanServ
  module Info
    def founder
      parse(/Founder(\s+):(\s+)(\w+)/, 3)
    end

    def successor
      parse(/Successor(\s+):(\s+)(\w+)/, 3)
    end

    def registered
      Date.parse(parse(/Registered\s+:\s+(\w+ [0-9]{2} [0-9(:?)]+ [0-9]{4})/, 1)).to_time
    end
  end
end
