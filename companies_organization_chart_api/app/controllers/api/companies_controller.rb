module Api
  class CompaniesController < ApplicationController
    def index
      companies = Company.all
      render json: companies, status: :ok
    end

    def create
      company = Company.new(company_params)
      if company.save
        render json: { company_id: company.id }, status: :created
      else
        render json: { errors: company.errors }, status: :precondition_failed
      end
    end

    def show
      company = Company.find_by(id: params[:id])
      if company
        render json: company, status: :ok
      else
        render json: { wrong_id: params[:id] }, status: :not_found
      end
    end

    private

    def company_params
      params.require(:company).permit(:name)
    end
  end
end
