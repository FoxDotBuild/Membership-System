class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string  :alias,         null: true
      t.integer :kisi_actor_id, null: false

      t.timestamps
    end

    create_table :award_issuances do |t|
      t.integer    :bounty, null: false, default: 0
      t.references :reason
      t.references :user,   null: false
      t.timestamps
    end

    create_table :award_reasons do |t|
      t.string     :name, null: false
      t.timestamps
    end
  end
end
