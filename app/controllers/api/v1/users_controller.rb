class Api::V1::UsersController < ApplicationController
    def index
        render json: User.all, include: :api_key
    end 

    def create 
        user = User.new(user_params)
        api_key = user.build_api_key
        if user.save 
            render json: {access_token: api_key.access_token}, status: :ok
        else 
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity 
        end 
    end 

    private 
    def user_params 
        params.require(:user).permit(:clientName, :clientEmail)
    end 
end
