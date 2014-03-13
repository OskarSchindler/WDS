namespace :schedulejobs do
  desc "Rake task to get events data"
  task :daily => :environment do
   	update_daily
 	end
end

namespace :schedulejobs do
  desc "Rake task to get events data"
  task :monthly => :environment do
   	update_monthly
 	end
end

def update_daily
   
	User.where(" leave != 10 ").update_all("workhour = workhour + 8")
	User.where(" leave == 10 ").update_all("leave = 0")
	User.where(" leave == 20 ").update_all("leave = 0")
	User.where(" leave == 21 ").update_all("leave = 0")
	User.where(" leave == 11 ").update_all("leave = 10")
	User.where(" leave == 122 ").update_all("leave = 10")
	User.where(" leave == 121 ").update_all("leave = 0")

	User.update_all("ideal_workhour = ideal_workhour + 8")

	User.where("overtime_count == 10").update_all("workhour = workhour + 2" )
	User.where("overtime_count == 10").update_all("overtime_count = 0" )
	User.where("overtime_count == 2 ").update_all("overtime_count = 0")
	User.where("overtime_count == 11").update_all("overtime_count = 10" )

	User.update_all("visible = 0")
	
	Overtime.update_all("ot = 0")

end

def update_monthly
	User.update_all("leave = 0,workhour = 0,visible = 0,overtime_count = 0,ideal_workhour = 0,leave_count = 0")
end
