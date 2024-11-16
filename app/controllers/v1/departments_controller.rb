# frozen_string_literal: true

module V1
  class DepartmentsController < V1BaseController
    skip_before_action :authenticate_v1_user!, only: [:index]

    def index
      dep = Department.all
      render json: { data: dep, message: 'suc' }, status: :ok
    end
  end
end
