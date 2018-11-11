class Member < ApplicationRecord
  API_KEY = ENV.fetch("kisi_api_token")

  def maybe_set_alias
    return if self.alias.present?
    json = JSON.parse(`curl -H "Authorization:KISI-LOGIN #{API_KEY}" https://api.getkisi.com/members?user_id=#{id}`)
    first_n, last_n = json.fetch("name").split(" ")
    update_attributes!(name: [first_n, last_n.first].join(" "))
  end
end
