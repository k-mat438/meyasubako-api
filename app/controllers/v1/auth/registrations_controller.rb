# frozen_string_literal: true

module V1
  module Auth
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      # コントローラ単位でwrapを防ぐ
      wrap_parameters format: []

      private

      def sign_up_params
        params.permit(:email, :password, :password_confirmation, :name)
      end
    end
  end
end
