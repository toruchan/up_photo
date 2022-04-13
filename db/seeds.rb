# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# plan
Plan.create(name: 'ライト', period: 0, limit_of_image: 10, limit_of_illustration: 10, limit_of_movie: 5, price: 10000)
Plan.create(name: 'ライト', period: 1, limit_of_image: 10, limit_of_illustration: 10, limit_of_movie: 5, price: 6000)
Plan.create(name: 'ベーシック', period: 0, limit_of_image: 20, limit_of_illustration: 20, limit_of_movie: 10, price: 18000)
Plan.create(name: 'ベーシック', period: 1, limit_of_image: 20, limit_of_illustration: 20, limit_of_movie: 10, price: 10800)
Plan.create(name: 'ロイヤル', period: 0, limit_of_image: 30, limit_of_illustration: 30, limit_of_movie: 15, price: 24000)
Plan.create(name: 'ロイヤル', period: 1, limit_of_image: 30, limit_of_illustration: 30, limit_of_movie: 15, price: 14400)
Plan.create(name: 'プロフェッショナル', period: 0, limit_of_image: 50, limit_of_illustration: 50, limit_of_movie: 30, price: 30000)
Plan.create(name: 'プロフェッショナル', period: 1, limit_of_image: 50, limit_of_illustration: 50, limit_of_movie: 30, price: 18000)

# image_tag
ImageTag.create(name: 'イメージタグ1')
ImageTag.create(name: 'イメージタグ2')
ImageTag.create(name: 'イメージタグ3')

# illustration_tag
IllustrationTag.create(name: 'イラストタグ1')
IllustrationTag.create(name: 'イラストタグ2')
IllustrationTag.create(name: 'イラストタグ3')

# movie_tag
MovieTag.create(name: '動画タグ1')
MovieTag.create(name: '動画タグ2')
MovieTag.create(name: '動画タグ3')

# image_category
ImageCategory.create(name: 'イメージカテゴリ1')
ImageCategory.create(name: 'イメージカテゴリ2')
ImageCategory.create(name: 'イメージカテゴリ3')

# illustration_category
IllustrationCategory.create(name: 'イラストカテゴリ1')
IllustrationCategory.create(name: 'イラストカテゴリ2')
IllustrationCategory.create(name: 'イラストカテゴリ3')

# movie_category
MovieCategory.create(name: '動画カテゴリ1')
MovieCategory.create(name: '動画カテゴリ2')
MovieCategory.create(name: '動画カテゴリ3')

# image_model
ImageModel.create(name: 'イメージモデル1')
ImageModel.create(name: 'イメージモデル2')
ImageModel.create(name: 'イメージモデル3')

# illustration_model
IllustrationModel.create(name: 'イラストモデル1')
IllustrationModel.create(name: 'イラストモデル2')
IllustrationModel.create(name: 'イラストモデル3')

# movie_model
MovieModel.create(name: '動画モデル1')
MovieModel.create(name: '動画モデル2')
MovieModel.create(name: '動画モデル3')

# user
User.create(email: 'user1@example.com', password: 'password', admin_flg: 1, plan_id: 1)
User.create(email: 'user2@example.com', password: 'password', admin_flg: 0, plan_id: 2)

# download_limit
DownloadLimit.create(limit_of_image: 10, limit_of_illustration: 10, limit_of_movie: 5, user_id:1)
