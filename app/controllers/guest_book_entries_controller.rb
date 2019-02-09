class GuestBookEntriesController < ApplicationController
  FIELDS = ["name", "email"]
  SLACK  = Slack::Notifier.new(ENV.fetch("SLACK_URL", "???"),
                               channel: "#managers",
                               username: "Foxy McFoxFace")

  def create
    p = params.fetch("guest_book_entry").permit(*FIELDS)
    GuestBookEntry.create!(p)
    redirect_to action: :new
  end

  def new
    @entry = GuestBookEntry.new
  end
end
