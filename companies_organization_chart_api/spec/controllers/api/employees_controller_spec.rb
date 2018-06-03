require 'rails_helper'

RSpec.describe Api::EmployeesController, type: :controller do
  let(:company) { create(:company) }

  context '#index' do
    before do
      3.times { create(:employee, company: company) }
    end

    it 'gets employees from a company' do
      get :index, params: { company_id: company.id }

      content = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(content.count).to eq(3)
    end
  end

  context '#create' do
    it 'creates an employee for a company' do
      post :create, params: {
        company_id: company.id,
        employee: {
          name: 'Kaya Ann',
          email: 'k.ann@email.com'
        }
      }

      content = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(content).to have_key('employee_id')
      expect(content['employee_id']).not_to be_nil
    end

    it 'has an error creating an employee' do
      post :create, params: {
        company_id: company.id,
        employee: {
          name: 'K',
          email: 'fake_email'
        }
      }

      content = JSON.parse(response.body)
      expect(response).to have_http_status(:precondition_failed)
      expect(content).to have_key('errors')
      expect(content['errors']).not_to be_empty
    end
  end

  context '#destroy' do
    let!(:employee) { create(:employee, company: company) }

    subject do
      delete :destroy, params: {
        company_id: company.id,
        id: employee.id
      }
    end

    it 'destroys an employee' do
      expect { subject }.to change { Employee.count }.from(1).to(0)
    end

    it 'fails to destroy an employee' do
      allow(Employee).to receive(:find_by).and_return(employee)
      allow(employee).to receive(:destroy).and_return(false)

      delete :destroy, params: {
        company_id: company.id,
        id: employee.id
      }

      expect(response).to have_http_status(:internal_server_error)
      expect(Employee.count).to eq(1)
    end

    it 'return not_found if employee does not exist' do
      delete :destroy, params: {
        company_id: company.id,
        id: employee.id + 1
      }

      expect(response).to have_http_status(:not_found)
      expect(Employee.count).to eq(1)
    end
  end
end
