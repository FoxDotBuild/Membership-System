class AddReferalToGuest < ActiveRecord::Migration[5.2]
  def change
    add_column :guest_book_entries, :referral, :string
    add_column :guest_book_entries, :misc, :string
  end
end
