# frozen_string_literal: true

module V1
  class PostsController < V1BaseController
    skip_before_action :authenticate_v1_user!, only: %i[index create]
    def index
      posts = Post.all
      render json: { data: posts, message: 'success' }, status: :ok
    end

    def create
      post = Post.new(
        content: params[:content],
        user_id: params[:user_id],
        department_id: find_department_id,
        business_id: find_business_id,
        category_id: find_category_id
      )

      if post.save
        render json: { message: 'Post created successfully' }, status: :created
      else
        render json: {
          message: 'Failed to create post',
          errors: post.errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    private

    def find_department_id
      Department.find_by!(name: params[:department])&.id
    end

    def find_business_id
      Business.find_by!(name: params[:businesses])&.id
    end

    def find_category_id
      Category.find_by!(name: params[:categories])&.id
    end
  end
end
