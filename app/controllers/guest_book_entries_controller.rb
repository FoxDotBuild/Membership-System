class GuestBookEntriesController < ApplicationController
  FIELDS = ["name", "email", "referral", "misc"]
  SLACK  = Slack::Notifier.new(ENV.fetch("SLACK_URL", "???"),
                               channel: "#managers",
                               username: "Foxy McFoxFace")
  REPORT_TPL = [
    "```",
    "Name: %{name}",
    "Email: %{email}",
    "How did you hear about us?: %{referral}",
    "Comments (optional): %{misc}",
    "```",
  ].join("\n")

  def create
    p   = params.fetch("guest_book_entry").permit(*FIELDS)
    gbe = GuestBookEntry.create!(p)
    tpl = gbe.as_json.deep_symbolize_keys
    SLACK.ping(REPORT_TPL % tpl)
    redirect_to action: :new
  end

  def new
    @entry = GuestBookEntry.new
  end
end
