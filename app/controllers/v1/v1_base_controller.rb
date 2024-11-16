# frozen_string_literal: true

module V1
  class V1BaseController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_v1_user!
  end
end
