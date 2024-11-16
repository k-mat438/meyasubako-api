# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clear existing data
Rails.logger.debug 'Clearing existing data...'
[Category, Business, Department, Post, User].each(&:delete_all)

# Create Departments
Rails.logger.debug 'Creating Departments...'
departments = %w[全体 開発 総務 広告 営業 マーケティング]
department_records = {}

departments.each do |department_name|
  department_records[department_name] = Department.create!(name: department_name)
end

# Modified business structure with unique names
Rails.logger.debug 'Creating Businesses...'
business_structure = {
  '全体' => %w[全社事業A 全社事業C],
  '開発' => %w[開発事業A 開発事業B],
  '総務' => ['総務事業D'],
  '広告' => %w[A広告事業 B広告事業 C広告事業],
  '営業' => ['営業事業D'],
  'マーケティング' => %w[マーケティング事業E マーケティング事業F]
}

business_records = {}
business_structure.each do |department_name, businesses|
  department = department_records[department_name]
  businesses.each do |business_name|
    business_records[business_name] = Business.create!(
      name: business_name,
      department: department
    )
  end
end

# Create Categories
Rails.logger.debug 'Creating Categories...'
categories = ['良い点', '改善点・提案', '質問']
category_records = {}
categories.each do |category_name|
  category_records[category_name] = Category.create!(name: category_name)
end

# Create Users
Rails.logger.debug 'Creating Users...'
user_names = %w[
  山田太郎 佐藤花子 鈴木一郎 田中美咲 伊藤健太
  加藤優子 高橋誠 渡辺康弘 小林美穂 吉田健一
]

user_records = user_names.map.with_index(1) do |name, id|
  User.create!(
    name: name,
    email: "user#{id}@example.com",
    image: Faker::Avatar.image,
    department: department_records.values.sample,
    is_guest: Faker::Boolean.boolean(true_ratio: 0.2),
    is_admin: Faker::Boolean.boolean(true_ratio: 0.1),
    password: 'password',
    password_confirmation: 'password'
  )
end

# Create Posts with updated business names
Rails.logger.debug 'Creating Posts...'
sample_posts = [
  {
    department: '広告',
    business: 'A広告事業',
    category: '改善点・提案',
    content: 'A広告の進捗が遅れています。対策を考える必要があります。'
  },
  {
    department: '開発',
    business: '開発事業A',
    category: '良い点',
    content: 'D事業の売上が好調です。チームの努力が実を結んでいます。'
  },
  {
    department: '総務',
    business: '総務事業D',
    category: '改善点・提案',
    content: 'E事業の新しいマーケティング戦略を提案します。顧客層を拡大できる可能性があります。'
  },
  {
    department: '広告',
    business: 'B広告事業',
    category: '質問',
    content: 'B広告の予算について質問があります。増額の可能性はありますか？'
  },
  {
    department: '開発',
    business: '開発事業B',
    category: '改善点・提案',
    content: 'F事業のターゲット設定に疑問を感じています。再考の余地があるのではないでしょうか。'
  }
]

# Create sample posts
sample_posts.each do |post_data|
  Post.create!(
    user: user_records.sample,
    department: department_records[post_data[:department]],
    business: business_records[post_data[:business]],
    category: category_records[post_data[:category]],
    content: post_data[:content]
  )
end

# Add additional random posts
20.times do
  department = department_records.values.sample
  business = Business.where(department: department).sample

  Post.create!(
    user: user_records.sample,
    department: department,
    business: business,
    category: category_records.values.sample,
    content: Faker::Lorem.paragraph(sentence_count: 3)
  )
end

Rails.logger.debug 'Seed data creation completed!'
