class Member < ApplicationRecord
  API_KEY = ENV.fetch("kisi_api_token")

  def maybe_set_alias
    return if alias.present?
    json = JSON.parse(`curl -H "Authorization:KISI-LOGIN #{API_KEY}" https://api.getkisi.com/members?user_id=#{id}`)
    update_attributes!(name: json.fetch("name"))
  end
end
