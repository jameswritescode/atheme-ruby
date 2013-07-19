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

  parse :list do
    command :to_a do
      output = raw_services_output.split("\n")
      output.delete_at(0)
      output.delete_at(output.length - 1)

      output.map do |info|
        out     = info.sub('- ', '').split('(')
        channel = out[0].sub(' ', '')
        owner   = out[1].sub(')', '').sub(' ', '')

        { channel: channel, owner: owner }
      end
    end
  end
end
