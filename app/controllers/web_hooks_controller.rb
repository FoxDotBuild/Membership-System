class WebHooksController < ApplicationController
  class KisiEntry < Mutations::Command
    VISIT               = "You visitied the space"
    # How much a single visit is worth in XP Points.
    DEFAULT_VISIT_WORTH = 60
    AWARD_REASON        = AwardReason.find_or_create_by(name: VISIT)
    THIS_TIMEFRAME      = "created_at > ?"
    TIME_SLICE          = 6.hours

    required do
      # OTHER STUFF WE DONT USE ================================================
      # integer :id
      # integer :object_id
      # string  :code         # No idea
      # string  :created_at   # format: "2018-11-10T22:24:34+00:00"
      # string  :message      # "Fox.Build (Administrator Account) ..."
      # array :references do
      #   interger :id
      #   string   :type      #,  in: ["Place", "Lock"]
      # end
      # ========================================================================

      integer :actor_id
      boolean :success,     in: [true]
      string  :action,      in: ["unlock"]
      string  :actor_type,  in: ["User"]
      string  :object_type, in: ["Lock"]
    end

    def validate
      too_many = AwardIssuance
        .where(kisi_actor_id: actor_id, created_at: time_range)
        .any?

      add_error :too_many, :too_many, "too many" if too_many
    end

    def execute
      AwardIssuance.create!(bounty: DEFAULT_VISIT_WORTH,
                            reason: AWARD_REASON,
                            user:   user)
    end

    private

    def time_range
      (Time.now - TIME_SLICE)..Time.now
    end

    def user
      @user ||= User.find_or_create_by!(kisi_actor_id: actor_id)
    end
  end

  skip_before_action :verify_authenticity_token

  def kisi
    KisiEntry.run!(raw_json)
    render json: "ok!"
  end

  def whatever
    render plain: "We have #{Member.count} members"
  end
end
