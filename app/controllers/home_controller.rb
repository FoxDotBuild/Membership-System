class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def root
    @day      = leadboard_for(since: 2.days.ago)
    @week     = leadboard_for(since: 1.week.ago)
    @all_time = leadboard_for(since: nil)
  end
private

  def leadboard_for(since: nil)
    Member
      .all
      .reduce({}) do |result, item|
        result.update(item.alias => item.total_points(since: since))
      end
      .to_a
      .sort_by { |x| x.last }
      .reverse
  end
end
