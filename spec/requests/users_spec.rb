require 'rails_helper'

describe 'Users', type: :request do
  describe 'GET #index' do
    before(:example) { get users_url }

    it 'successfull request' do
      expect(response.status).to eq(200)
    end

    it 'should render the index template' do
      expect(response).to render_template(:index)
    end
  end
  describe 'GET #show' do
    before(:example) { get user_url(1) }

    it 'successful request' do
      expect(response.status).to eq(200)
    end
    it 'should render the show template' do
      expect(response).to render_template(:show)
    end
  end
end
