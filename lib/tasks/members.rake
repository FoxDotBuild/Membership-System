namespace :members do
  desc "Assign real names to members that don't have any"
  task name: :environment do
    Member.all.map { |x| x.maybe_set_alias }
  end

  HEADER = "@tim Here are this week's guestbook entries:\n\n"

  desc "print a list of guestbook signups"
  task email_report: :environment do
    emails = GuestBookEntry.where("created_at > ?", 1.week.ago).pluck(:email).uniq.reject { |x| !x.include?("@") }.join("\n")
    msg = HEADER + emails
    GuestBookEntriesController::SLACK.ping(msg)
  end
end
