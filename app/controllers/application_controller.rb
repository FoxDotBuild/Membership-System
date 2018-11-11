class ApplicationController < ActionController::Base
  def raw_json
    @raw_json ||= JSON.parse(request.body.read).with_indifferent_access
  rescue JSON::ParserError
    raise OnlyJson
  end
end
