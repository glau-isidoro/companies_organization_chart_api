module Api
  class EmployeesController < ApplicationController
    def index
      employees = Employee.from_this_company(params[:company_id])
      render json: employees, status: :ok
    end

    def create
      employee = Employee.new(employee_params)
      if employee.save
        render json: { employee_id: employee.id }, status: :created
      else
        render json: { errors: employee.errors }, status: :precondition_failed
      end
    end

    def destroy
      employee = Employee.find_by(id: params[:id])
      return not_found unless employee
      if employee.destroy
        render json: {}, status: :ok
      else
        render json: {}, status: :internal_server_error
      end
    end

    private

    def employee_params
      params.require(:employee)
            .permit(:name, :email)
            .merge!(company_id: params[:company_id])
    end

    def not_found
      render json: { wrong_id: params[:id] }, status: :not_found
    end
  end
end
