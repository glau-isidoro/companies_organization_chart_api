class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.references :company, foreign_key: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
