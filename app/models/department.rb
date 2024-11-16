# frozen_string_literal: true

class Department < ApplicationRecord
  has_many :posts
  has_many :users
  has_many :businesses
end
