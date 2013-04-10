module Atheme::Parser
  def parse(expression, *groups)
    output = []

    groups.each do |n|
      output << expression.match(to_raw)[n]
    end

    output.join(' ')
  end
end
