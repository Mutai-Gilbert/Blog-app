require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:example) { get '/users/1/posts' }
    it 'should responce with success.' do
      expect(response.status).to eq(200)
    end
    it 'should render the index template' do
      expect(response).to render_template(:index)
    end
    it 'should render the index placeholder' do
      expect(response.body).to include('List of Users Posts')
    end
  end
  describe 'GET #show' do
    before(:example) { get '/users/1/posts/1' }
    it 'should return a success' do
      expect(response.status).to eq(200)
    end
    it 'should render the show template' do
      expect(response).to render_template(:show)
    end
    it 'should render the show placeholder' do
      expect(response.body).to include('User Posts Details')
    end
  end
end
