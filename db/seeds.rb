# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@password = "111111"

User.create!(name: "Admin",
             email: "admin@email.com",
             password: @password,
             password_confirmation: @password,
             admin: true)
             
User.create!(name: "はぁちゅう", email: "sample@email.com", password: @password, password_confirmation: @password, shop_name: "爬虫類倶楽部", address: "東京都中野区中野６丁目１５−１３",
  howto_access: "中野駅から徒歩5分 ⬇︎", tel: "03-3227-5122", business_hours: "13時〜20時", holiday: "木曜日", url: "http://www.hachikura.com/",
  handling_animals: "ヘビ、トカゲ、ヤモリ、カメ、両生類、奇虫・昆虫", handling_feeds: "活エサ・冷凍エサ・人工飼料・栄養剤・補助品・その他のエサ",
  handling_goods: "飼育セット/飼育ケージ/照明器具/保温器具/床材/レイアウト用品/水入れ・餌入れ/ナミバテラ社製品/本・ＤＶＤ/その他の飼育用品",
  feature: "取り扱い多数、御来店お待ちしております。", map_info: "https://maps.google.co.jp/maps?output=embed&q=35.708408,139.675565", twitter: "https://twitter.com/89_nakano"
)

puts "success create user."


Reptile.create!( image: "", type1: "ヘビ", type2: "ボールパイソン", sex: "オス", age: "5", size: "100cm", weight: "500g",
                  description: "", price: "10000", sales_status: "販売中", arrival_day: "", user_id: "2" )
Reptile.create!( image: "", type1: "ヘビ", type2: "リューシスティック", sex: "オス", age: "10", size: "100cm", weight: "500g",
                  description: "", price: "10000", sales_status: "販売中", arrival_day: "", user_id: "2" )
Reptile.create!( image: "", type1: "ヘビ", type2: "シブリング", sex: "オス", age: "5", size: "100cm", weight: "500g",
                  description: "", price: "10000", sales_status: "販売中", arrival_day: "", user_id: "2" )

puts "success create reptile."

# 1.times do |n|
#   name  = "user-#{n+1}"
#   email = "sample#{n+1}@email.com"
#   User.create!(name: name,
#                email: email,
#                password: @password,
#                password_confirmation: @password)
# end

