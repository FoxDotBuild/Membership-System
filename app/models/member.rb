class Member < ApplicationRecord
  API_KEY = ENV.fetch("KISI_API_KEY")

  def maybe_set_alias
    return if self.alias.present?
    json = JSON.parse(`curl -H "Authorization:KISI-LOGIN #{API_KEY}" https://api.getkisi.com/members?user_id=#{kisi_actor_id}`)
    first_n, last_n = json[0].fetch("name").split(" ")
    update_attributes!(alias: [first_n, last_n.first].join(" "))
  end
end
