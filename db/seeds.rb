exit(1) if Rails.env == "production"

REASON_ID = AwardReason.create!(name: "You visitied the space").id
NAMES     = ["Doug K", "Shane S", "Doug W", "Sam S", "Ethan I", "Steve O",
  "Nick H", "Jessica H", "Pat H", "Greg T", "Dan S", "Paul M", "Brian E", "Tim A",
  "John G", "Dean K", "Mark R", "Cleaning L", "Sarah C", "Sally G", "Robert H",
  "Mark A", "Erik R", "Robin S", "Andy G", "Bill G", "Probably Lon",
  "Probably Rick", "Paul S", "Glenna A", "Trent T", "Amanda J", "Theodore X",
  "Jeff E"]
NAMES.each_with_index do |name, index|
  member_id = Member.create!(alias: name, kisi_actor_id: index).id
  rand(2..10).times do
    AwardIssuance.create!(bounty:    60,
                          reason_id: REASON_ID,
                          member_id: member_id)
  end
end
