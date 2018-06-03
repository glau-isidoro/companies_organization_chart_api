require 'rails_helper'

RSpec.describe Api::CompaniesController, type: :controller do
  context 'success' do
    it 'gets all companies' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'creates a new company' do
      post :create, params: { company: {
        name: Faker::Company.name
      } }
      content = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(content).to have_key('company_id')
      expect(content['company_id']).not_to be_nil
    end

    it 'returns the company' do
      company = create(:company)
      get :show, params: {
        id: company.id
      }
      content = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(content['id']).to eq(company.id)
      expect(content['name']).to eq(company.name)
    end
  end

  context 'failure' do
    it 'has an error creating a company' do
      post :create, params: { company: {
        name: 'it'
      } }
      content = JSON.parse(response.body)
      expect(response).to have_http_status(:precondition_failed)
      expect(content).to have_key('errors')
      expect(content['errors']).not_to be_empty
    end

    it 'could not find a company' do
      company = create(:company)
      get :show, params: {
        id: company.id + 1
      }
      content = JSON.parse(response.body)
      expect(response).to have_http_status(:not_found)
      expect(content).to have_key('wrong_id')
      expect(content['wrong_id']).to eq((company.id + 1).to_s)
    end
  end
end
