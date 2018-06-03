class Employee < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true,
                    format: {
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
                    }

  belongs_to :company

  def self.from_this_company(company_id)
    Employee.where(company_id: company_id)
  end
end
