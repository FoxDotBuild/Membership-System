class Member < ApplicationRecord
  API_KEY = ENV.fetch("KISI_API_KEY", "---KEY-NOT-SET---")

  def total_points(since: 10.years.ago)
    AwardIssuance
      .where("created_at > ?", since)
      .where(member_id: self.id)
      .pluck(:bounty)
      .reduce(:+)
  end

  def maybe_set_alias
    return if self.alias.present?
    json      = JSON.parse(`curl -H "Authorization:KISI-LOGIN #{API_KEY}" https://api.getkisi.com/members?user_id=#{kisi_actor_id}`)
    full_name = (json || [])[0]["name"]
    return unless full_name
    first_n, last_n = full_name.split(" ")
    update_attributes!(alias: [first_n.split("@").first, (last_n || "_").first].join(" "))
  end
end
