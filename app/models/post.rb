# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :department
  belongs_to :user
  belongs_to :business
  belongs_to :category
end
