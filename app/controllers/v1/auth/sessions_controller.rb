# frozen_string_literal: true

module V1
  module Auth
    class SessionsController < DeviseTokenAuth::SessionsController
      private

      def resource_params
        params.permit(:email, :password)
      end
    end
  end
end
