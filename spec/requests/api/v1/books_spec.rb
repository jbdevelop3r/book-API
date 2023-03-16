require 'rails_helper'

RSpec.describe "Api::V1::BooksController", type: :request do
  let(:book_params) {{title: "New Book", description: "New Description"}}
  let!(:book) {FactoryBot.create(:book)}

  describe "POST /api/v1/books" do
    context "creates a book with valid params" do 
      before {post "/api/v1/books", params: {book: book_params}}
      
      it "returns a :created http response" do 
        expect(response).to have_http_status(201)
        expect(Book.count).to eq(1)
      end 
    end 

    context "with invalid params" do 
      before {post "/api/v1/books", params: {book: {title: nil}}}
      
      it "returns a error  response" do 
        expect(response).to have_http_status(422)
      end 
    end 
  end 

  describe "PUT /api/v1/books/:id" do 
    context "updates a book with valid params" do
       before do 
        put "/api/v1/books/#{book.id}", params: {book: {title: "Updated book title", description: "Updated book description"}}
        book.reload
      end
      
      it "returns a 200 status response" do 
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)["message"]).to eq("Book has been updated")
        expect(book.title).to eq("Updated book title")
      end 
    end 

    context "with invalid params" do
      before do 
       put "/api/v1/books/#{book.id}", params: {book: {title: nil, description: "Updated book description"}}
     end
     
     it "returns a 422 status response" do 
       expect(response).to have_http_status(422)
     end 
   end 

   context "with invalid id" do
    before {put "/api/v1/books/0"}

    it "returns a 200 response status" do 
      expect(response).to have_http_status(404)
      expect(JSON.parse(response.body)["error"]).to eq("Book does not exist.")
    end 
  end 
  end 

  describe "DELETE /api/v1/books/:id" do 
    context "deletes a book with valid id" do
      before {delete "/api/v1/books/#{book.id}"}

      it "returns a 200 response status" do 
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)["message"]).to eq("#{book.title} has been deleted.")
      end 
    end 

    context "with invalid id" do
      before {delete "/api/v1/books/0"}

      it "returns a 200 response status" do 
        expect(response).to have_http_status(404)
        expect(JSON.parse(response.body)["error"]).to eq("Book does not exist.")
      end 
    end 
  end 

  describe "GET /api/v1/books" do 
    context "loads all books" do
      before {get "/api/v1/books"}

      it "returns a 200 status respoonse" do 
        expect(response).to have_http_status(200)
      end 
    end 
  end 

  describe "GET /api/v1/books/:id" do 
    context "loads all books" do
      before {get "/api/v1/books/#{book.id}"}

      it "returns a 200 status respoonse" do 
        expect(response).to have_http_status(200)
      end 
    end 

    context "with invalid id" do
      before {get "/api/v1/books/0"}

      it "returns a 200 response status" do 
        expect(response).to have_http_status(404)
        expect(JSON.parse(response.body)["error"]).to eq("Book does not exist.")
      end 
    end 
  end 
end
