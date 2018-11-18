class WebHooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def kisi
    KisiEntry.run(raw_json)
    render json: "ok!"
  end
end
