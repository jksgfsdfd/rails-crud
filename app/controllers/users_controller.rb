class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        puts params
        @user = User.new(params.require(:user).permit(:username,:email,:password))
        if @user.save
            flash[:notice] = "Welcome #{@user.username}"
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def edit
        
        if logged_in? && current_user.id.to_s == params[:id]
            @user = User.find(params[:id])
        else 
            flash[:notice] = "You can only edit your account"
            redirect_to root_path
        end
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(params.require(:user).permit(:username,:email,:password))
            flash[:notice] = "Updated successfully"
            redirect_to articles_path
        else
            render 'edit'
        end
    end

    def show 
        @user = User.find(params[:id])
    end 

    def index
        @users = User.all
    end

    def destroy
        #delete all his articles,delete the user and logout him
        user = current_user
        puts "###################################################################################"
        puts user
        puts "###################################################################################"
        user.destroy
        session[:user_id] = nil
        flash[:notice] = "Account deleted"
        redirect_to login_path
    end
end