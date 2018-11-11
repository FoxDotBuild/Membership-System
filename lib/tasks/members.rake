namespace :members do
  desc "Assign real names to members that don't have any"
  task name: :environment do
    Member.all.map { |x| x.maybe_set_alias }
  end
end
