class Company < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }

  has_many :employees, dependent: :destroy
end
