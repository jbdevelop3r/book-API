class Api::V1::BooksController < ApplicationController
    
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :restrict_access
    before_action :set_book, only: [:update, :destroy, :show]

    def index 
        render json: Book.all, status: :ok
    end 

    def show 
        render json: @book, status: :ok
    end 
    
    def create 
        @book = Book.new(book_params)
        if @book.save 
            render json: @book, status: :created 
        else  
            render json: @book.errors, status: :unprocessable_entity
        end    
    end 

    def update 
        if @book.update(book_params) 
            render json: {message: "Book has been updated", data: @book}, status: :ok 
        else  
            render json: @book.errors, status: :unprocessable_entity
        end 
    end 

    def destroy 
        @book.destroy 
        render json: {message: "#{@book.title} has been deleted."}, status: :ok 
    end 

    private 
    def book_params 
        params.require(:book).permit(:title, :description)
    end 

    def set_book 
        @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Book does not exist."}, status: :not_found
    end 

    def restrict_access 
        authenticate_or_request_with_http_token do |token|
            ApiKey.exists?(access_token: token)
        end 
    end 

end
