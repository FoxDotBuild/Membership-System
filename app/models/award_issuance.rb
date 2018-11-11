class AwardIssuance < ApplicationRecord
end

result = {}
Member.all.each do |item|
  result[item.alias] = AwardIssuance.where(member_id: item.id).pluck(:bounty).reduce(:+)
end
result.to_a.map{|pair| pair.join(": ")}.join("\n")
