class ApplicationController < ActionController::Base
  def raw_json
    @raw_json ||= JSON.parse(request.body.read).tap{ |x| symbolize(x) }
  rescue JSON::ParserError
    raise OnlyJson
  end
end
