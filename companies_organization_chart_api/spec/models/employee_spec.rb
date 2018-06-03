require 'rails_helper'

RSpec.describe Employee, type: :model do
  context 'validations' do
    it 'is not valid without a name' do
      employee = build(:employee, name: '')
      expect(employee).not_to be_valid
    end

    it 'is not valid with a short name' do
      employee = build(:employee, name: 'A')
      expect(employee).not_to be_valid
    end

    it 'is valid with a name' do
      employee = build(:employee, name: 'Artchie Ritchie')
      expect(employee).to be_valid
    end

    it 'is not valid without a email' do
      employee = build(:employee, email: '')
      expect(employee).not_to be_valid
    end

    it 'is not valid with a invalid email' do
      employee = build(:employee, email: 'email')
      expect(employee).not_to be_valid
    end

    it 'is valid with a valid email' do
      employee = build(:employee, email: 'name@email.com')
      expect(employee).to be_valid
    end
  end

  context '#from_this_company' do
    before do
      @first_company = create(:company)
      @second_company = create(:company)
      3.times { create(:employee, company: @first_company) }
      5.times { create(:employee, company: @second_company) }
    end

    it 'returns employees from the same company' do
      employees = Employee.from_this_company(@first_company.id)
      expect(employees.count).to eq(3)
      expect(
        employees.pluck(:company_id).flatten.uniq
      ).to eq([@first_company.id])
    end

    it 'does not returns employees from other company' do
      employees = Employee.from_this_company(@first_company.id)
      expect(
        employees.pluck(:company_id).flatten
      ).not_to include(@second_company.id)
    end
  end
end
