namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
end
end

def make_users

  5.times do |n|
    name  = Faker::Name.name
    email = "P-#{n+1}@g.c"
    designation = 1
    password  = "123456"
    leave = 0,
    workhour = 0,
    visible = 0,
    designation_id = 1,
    overtime_count = 0,
    ideal_workhour = 0,
    leave_count = 0,
    paid_leave_count = 0,
    overtime_allocation = 0,
    User.create!(name:     name,
                 email:    email,
		 designation: designation,
                 password: password,
                 password_confirmation: password,
		leave: 0,
    		workhour: workhour,
    		visible: visible,
		designation_id: designation_id,
    		overtime_count: overtime_count,
		ideal_workhour: ideal_workhour,
		leave_count: leave_count,
		paid_leave_count: paid_leave_count,
		overtime_allocation: overtime_allocation)
  end


end
