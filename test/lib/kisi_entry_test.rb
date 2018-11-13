
require "test_helper"
require "pry"

class KisiEntryTest < ActiveSupport::TestCase
  test "does not over-award for multi entry" do
    # Create stubs
    stubs        = [ member = Member.create!(kisi_actor_id: 5) ]
    fake_webhook = { actor_id:    member.kisi_actor_id,
                     success:     true,
                     action:      "unlock",
                     actor_type:  "User",
                     object_type: "Lock" }

    assert KisiEntry.run!(fake_webhook).is_a?(AwardIssuance)
    refute KisiEntry.run(fake_webhook).success?
    stubs.map(&:destroy!)
  end
end
