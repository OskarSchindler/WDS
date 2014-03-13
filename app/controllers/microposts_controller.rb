class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
 	@micropost = current_user.microposts.build(micropost_params)
	
	check = 0

	if @micropost.trigger == 1
		if params[:commit] == "Take a Leave"

			User.update_all("leave = 11,leave_count = leave_count + 1,overtime_count = 2" , :id => current_user )

			Overtime.update_all("ot = ot + 8",:id => current_user.designation_id)
			
			counter1 = 0
			counter2 = 2

			group = User.find(:all, :conditions => {designation_id: current_user.designation_id})
			
        		group.each do |user|

			overtime = Overtime.find(current_user.designation_id)
			
			if user!=current_user
			if user.overtime_allocation == 0 && overtime.ot != 0 && user.leave == 0

			Overtime.update_all("ot = ot - 4",:id => current_user.designation_id)

			user.leave = 21
			user.overtime_count = 11
			user.overtime_allocation = 1

			user.save!(:validate => false)

			counter1 = counter1 + 1 

			end 
 
			if counter1 == 2
				
			user.overtime_allocation = 0
			user.save!(:validate => false)
			counter2 = counter2 - 1

			if counter2 == 0
				counter1 == 0
			end

			if user = group.last && counter2!=0
				group = User.find(:all, :conditions => {designation_id: current_user.designation_id},:limit => 4)
			end
			end
			end 
			end			

			@micropost.save
			flash[:success] = "Leave taken!"
		else params[:commit] == "Apply for Leave"

			User.update_all("leave = 121,overtime_count = 2" , :id => current_user )
		
			Overtime.update_all("ot = ot + 8",:id => current_user.designation_id)

			temp_user=User.find(:all,:conditions => ["designation = ?", current_user.designation])
			User.where(:id => temp_user).where("leave == 0").where("overtime_count == 0").update_all("visible = 1")
			User.update_all("visible = 0",:id => current_user)

			@micropost.save
			flash[:success] = "Request for leave is in process!"
		end

	else
		if params[:commit] == "Accept"
	
			overtime = Overtime.find(current_user.designation_id)

			if overtime.ot != 0
				overtime.ot = overtime.ot - 4
				overtime.save!

				if overtime.ot == 0
					User.where("leave = 121").update_all("leave = 122,paid_leave_count = paid_leave_count + 1, overtime_count = 2")
				end				
	
				User.update_all("visible = 0,overtime_count = 11",:id => current_user)
				User.update_all("leave = 20" , :id => current_user )

				@micropost.save
				flash[:success] = "Overtime allocated!"
			else
				check = 1
				@micropost.destroy

				flash[:success] = "Overtime not available!"	

				temp_user=User.find(:all,:conditions => ["designation = ?", current_user.designation])
				User.where(:id => temp_user).update_all("visible = 0")
				User.update_all("visible = 2", :id => current_user)
	
			end
		else params[:commit] == "Reject"
			check = 1
			@micropost.destroy
			flash[:success] = "Overtime rejected!"
		
			User.update_all("visible = 0", :id => current_user)
		end
	end
	redirect_to root_url
  end
  
  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost,).permit(:content, :trigger)
    end
  
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
