namespace :populatekarma do
  desc "GET THAT KARMA"
  task :task_name => :environment do
    User.all.each do |user|
      user.update_attribute(:total_karma_points, user.total_karma)
    end
  end
end
