class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def root
    result = {}
    Member.all.each do |item|
      result[item.alias] = AwardIssuance
                            .where(member_id: item.id)
                            .pluck(:bounty)
                            .reduce(:+)
    end
    @result = result
                .to_a
                .sort_by { |x| x.last }
                .reverse
                # .map { |pair| pair.join(": ") }.join("\n")

  end
end
