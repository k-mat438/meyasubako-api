# frozen_string_literal: true

module V1
  class BusinessesController < V1BaseController
    skip_before_action :authenticate_v1_user!, only: [:index]

    def index
      bus = Businesses.all
      render json: { data: bus, message: 'suc' }, status: :ok
    end
  end
end
