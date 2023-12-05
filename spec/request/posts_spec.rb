require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    it 'Response status is correct' do
      get '/users/:id/posts'
      expect(response).to have_http_status(:ok)
    end

    it 'Returns a successful response for index' do
      get '/users/:id/posts'
      expect(response).to be_successful
    end

    it 'Response body includes correct placeholder text' do
      get '/users/:id/posts'
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET #show' do
    it 'Response status is correct' do
      get '/users/:id/posts/:id'
      expect(response).to have_http_status(:ok)
    end

    it 'Returns a successful response for show' do
      get '/users/:id/posts/:id'
      expect(response).to be_successful
    end

    it 'Response body includes correct placeholder text' do
      get '/users/:id/posts/:id'
      expect(response.body).to include('This is the user post1')
    end
  end
end
