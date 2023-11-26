# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 削除したいとき
# Brand.where(name: 'プレミアム・ショコラート').destroy_all
# Product.where(name: 'ミルクタブレット').destroy_all

Admin.find_or_create_by!(email: 'admin@admin.com') do |admin|
  admin.password = 'chocomate'
end

hoge_brand1=Brand.find_or_create_by!(name: 'Art de Ganache')
hoge_brand2=Brand.find_or_create_by!(name: 'French Delishues Chocolat')
hoge_brand3=Brand.find_or_create_by!(name: 'Charm de Chocolat')
hoge_brand4=Brand.find_or_create_by!(name: '京都ベルギーチョコリエ')
Brand.find_or_create_by!(name: 'プレミアム・ショコラート')
Brand.find_or_create_by!(name: 'ロイヤル・カカオ')

hoge_origin1=Origin.find_or_create_by!(name: 'ブラジル')
hoge_origin2=Origin.find_or_create_by!(name: 'エクアドル')
hoge_origin3=Origin.find_or_create_by!(name: 'ベネズエラ')
Origin.find_or_create_by!(name: 'ペルー')
Origin.find_or_create_by!(name: 'コロンビア')
Origin.find_or_create_by!(name: 'ドミニカ共和国')
hoge_origin4=Origin.find_or_create_by!(name: 'その他')

hoge_type1=Type.find_or_create_by!(name: 'ミルクチョコレート')
hoge_type2=Type.find_or_create_by!(name: 'ダークチョコレート')
Type.find_or_create_by!(name: 'ホワイトチョコレート')
Type.find_or_create_by!(name: 'ビターチョコレート')
Type.find_or_create_by!(name: 'ルビーチョコレート')
hoge_type3=Type.find_or_create_by!(name: 'アソート')
hoge_type4=Type.find_or_create_by!(name: 'その他')

Product.find_or_create_by!(name: 'Art de Ganacheセレクション8粒') do |product|
  product.brand_id=hoge_brand1.id
  product.type_id=hoge_type3.id
  product.origin_id=hoge_origin4.id
  product.price= '2600'
end

Product.find_or_create_by!(name: 'ピスタチオトリュフ4粒') do |product|
  product.brand_id=hoge_brand1.id
  product.type_id=hoge_type4.id
  product.origin_id=hoge_origin4.id
  product.price= '1200'
end

Product.find_or_create_by!(name: 'エクアドル 70%') do |product|
  product.brand_id=hoge_brand2.id
  product.type_id=hoge_type2.id
  product.origin_id=hoge_origin2.id
  product.price= '900'
end

Product.find_or_create_by!(name: 'ベネズエラ 70%') do |product|
  product.brand_id=hoge_brand2.id
  product.type_id=hoge_type2.id
  product.origin_id=hoge_origin3.id
  product.price= '900'
end

Product.find_or_create_by!(name: 'シングルオリジンセレクション2023') do |product|
  product.brand_id=hoge_brand3.id
  product.type_id=hoge_type2.id
  product.origin_id=hoge_origin4.id
  product.price= '2900'
end

Product.find_or_create_by!(name: '日本茶チョコレート') do |product|
  product.brand_id=hoge_brand4.id
  product.type_id=hoge_type3.id
  product.origin_id=hoge_origin4.id
  product.price= '2500'
end

Product.find_or_create_by!(name: 'ミルクタブレット') do |product|
  product.brand_id=hoge_brand4.id
  product.type_id=hoge_type1.id
  product.origin_id=hoge_origin1.id
  product.price= '550'
end

Product.find_or_create_by!(name: 'ダークタブレット') do |product|
  product.brand_id=hoge_brand4.id
  product.type_id=hoge_type2.id
  product.origin_id=hoge_origin3.id
  product.price= '550'
end