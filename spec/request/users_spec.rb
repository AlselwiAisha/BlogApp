require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    it 'Response status is correct' do
      get '/users'
      expect(response).to have_http_status(:ok)
    end

    it 'Returns a successful response for index' do
      get '/users'
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'Response body includes correct placeholder text' do
      get '/users'
      expect(response.body).to include('List of Users')
    end
  end

  describe 'GET #show' do
    it 'Response status is correct' do
      get '/users/:id'
      expect(response).to have_http_status(:ok)
    end

    it 'Returns a successful response for show' do
      get '/users/:id'
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'Response body includes correct placeholder text' do
      get '/users/:id'
      expect(response.body).to include('User data')
    end
  end
end
