module Atheme::Parser::ChanServ
  extend Atheme::Parser

  parse :info do
    command(:founder) { match(/Founder\s+:\s+(\w+)/) }

    command :registered do
      Date.parse(match(/Registered\s+:\s+(\w+ [0-9]{2} [0-9(:?)]+ [0-9]{4})/)).to_time
    end

    command :successor do
      raw_services_output.match(/Successor\s+:\s+\(none\)/) ? nil : match(/Successor\s+:\s+(\w+)/)
    end
  end
end
