require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'is not valid without a name' do
    company = build(:company, name: '')
    expect(company).not_to be_valid
  end

  it 'is not valid with a short name' do
    company = build(:company, name: 'It')
    expect(company).not_to be_valid
  end

  it 'is valid with a name' do
    company = build(:company, name: 'Hirthe-Ritchie')
    expect(company).to be_valid
  end
end
