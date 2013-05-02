module Atheme::ParserHelper
  def match(expression)
    expression.match(raw_services_output)[1]
  end
end
