class GuestBookEntriesController < ApplicationController
  FIELDS = ["name", "email"]

  def create
    p = params.fetch("guest_book_entry").permit(*FIELDS)
    GuestBookEntry.create!(p)
    redirect_to action: :new
  end

  def new
    @entry = GuestBookEntry.new
  end
end
