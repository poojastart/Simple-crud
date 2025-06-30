class UsersController < ApplicationController
  before_action :authenticate_user!
 
  def show
    @user = User.find(params[:id])
  end

   def create
    super do |resource|
      if resource.persisted?
        respond_to do |format|
          format.html { redirect_to root_path }
          format.turbo_stream { redirect_to root_path }
        end
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.turbo_stream { 
            render turbo_stream: turbo_stream.replace("new_user", partial: "devise/registrations/form", locals: { resource: resource })
          }
        end
      end
    end
  end
end 