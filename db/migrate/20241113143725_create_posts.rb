# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false, foreign_key: true, index: true
      t.integer :department_id, null: false, foreign_key: true, index: true
      t.integer :business_id, null: false, foreign_key: true, index: true
      t.integer :category_id, null: false, foreign_key: true, index: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
