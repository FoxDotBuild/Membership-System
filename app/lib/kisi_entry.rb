# Take Kisi webhook data (for `unlock` actions) and pipe it into here.
class KisiEntry < Mutations::Command
  VISIT               = "You visitied the space"
  # How much a single visit is worth in XP Points.
  DEFAULT_VISIT_WORTH = 60
  AWARD_REASON        = AwardReason.find_or_create_by(name: VISIT)
  THIS_TIMEFRAME      = "created_at > ?"
  TIME_SLICE          = 6.hours
  SLACK               = Slack::Notifier.new(ENV.fetch("SLACK_URL", "???"),
                                            channel: "#who_is_in_the_shop",
                                            username: "Shop_Bot")
  # OTHER STUFF WE DONT USE ================================================
  # integer(:id), integer(:object_id), string(:code), string(:created_at),
  # string(:message), array(:references) { interger(:id); string(:type) }
  # ========================================================================
  required do
    integer :actor_id
    boolean :success,     in: [true]
    string  :action,      in: ["unlock"]
    string  :actor_type,  in: ["User"]
    string  :object_type, in: ["Lock"]
  end

  def validate
    too_many = \
      AwardIssuance.where(member_id: member.id, created_at: time_range).any?

    add_error :too_many, :too_many, "too many" if too_many
  end

  def execute
    maybe_slack_it
    AwardIssuance.create!(bounty:    DEFAULT_VISIT_WORTH,
                          reason_id: AWARD_REASON.id,
                          member_id: member.id)
  end

  private

  def maybe_slack_it
    if ENV["SLACK_URL"] && member.alias
      raise "NOT DONE"
    end
  end

  def time_range
    (Time.now - TIME_SLICE)..Time.now
  end

  def member
    @member ||= Member.find_or_create_by!(kisi_actor_id: actor_id)
  end
end

