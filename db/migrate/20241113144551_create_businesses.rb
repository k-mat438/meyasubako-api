# frozen_string_literal: true

class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name, null: false
      t.integer :department_id, null: false, foreign_key: true, index: true

      t.timestamps
    end

    add_index :businesses, :name, unique: true
  end
end
