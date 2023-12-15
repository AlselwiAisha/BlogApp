# spec/requests/users_spec.rb
require 'swagger_helper'

describe 'Users API' do
  path '/users' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          surname: { type: :string }
        },
        required: %w[name surname]
      }

      response '201', 'user created' do
        let(:user) { { name: 'foo', surname: 'bar' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    get 'Retrieves a user' do
      tags 'users', 'Another Tag'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', 'user found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 surname: { type: :string }
               },
               required: %w[id name surname]

        let(:id) { user.create(name: 'foo', surname: 'bar').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/foo' }
        run_test!
      end
    end
  end
end
