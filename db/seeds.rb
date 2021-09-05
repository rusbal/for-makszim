def create_users
  truncate('users')
  15.times { FactoryBot.create(:user) }
  p "Created #{User.count} users."
end

def truncate(table_name)
  ActiveRecord::Base.connection.execute("TRUNCATE #{table_name} RESTART IDENTITY")
end

create_users
