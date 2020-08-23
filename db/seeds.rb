# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@password = "111111"

User.create!( name: "Admin", email: "admin@email.com", password: @password, password_confirmation: @password, admin: true )

User.create!(
  name: "test_user1", email: "sample@email.com", password: @password, password_confirmation: @password, shop_name: "レプタイルショップ", shop_images: "",
  address: "東京都中野区中野６丁目１５−１３", howto_access: "xx駅から徒歩y分 ⬇︎", tel: "03-xxxx-xxxx", business_hours: "xx時〜yy時", holiday: "○曜日", url: "http://www.hachikura.com/",
  handling_animals: "ヘビ、トカゲ、ヤモリ、カメ、両生類、奇虫・昆虫", handling_feeds: "活エサ・冷凍エサ・人工飼料・栄養剤・補助品・その他のエサ",
  handling_goods: "飼育セット/飼育ケージ/照明器具/保温器具/床材/レイアウト用品/水入れ・餌入れ/ナミバテラ社製品/本・ＤＶＤ/その他の飼育用品",
  feature: "取り扱い多数、御来店お待ちしております。", map_info: "https://maps.google.co.jp/maps?output=embed&q=35.708408,139.675565", twitter: "https://twitter.com/89_nakano"
)
  # File.open("./public/uploads/TestFolder/user2.jpg")
  # File.open("./public/uploads/TestFolder/user3.jpg")
User.create!(
  name: "test_user2", email: "sample2@email.com", password: @password, password_confirmation: @password, shop_name: "爬虫類らんど", shop_images: "",
  address: "茨城県日立市中成沢町3-14-7", howto_access: "xx駅から徒歩y分 ⬇︎", tel: "02-xxxx-xxxx", business_hours: "xx時〜yy時", holiday: "○曜日", url: "https://www.w-monster.com/",
  handling_animals: "ヘビ、トカゲ、ヤモリ、カメ、両生類、奇虫・昆虫", handling_feeds: "活エサ・冷凍エサ・人工飼料・栄養剤・補助品・その他のエサ",
  handling_goods: "飼育セット/飼育ケージ/照明器具/保温器具/床材/レイアウト用品/水入れ・餌入れ/ナミバテラ社製品/本・ＤＶＤ/その他の飼育用品",
  feature: "取り扱い多数、御来店お待ちしております。", map_info: "https://maps.google.co.jp/maps?output=embed&q=36.574923,140.63526", twitter: "https://twitter.com/89_nakano"
)
puts "success create user."

# Test 生体登録
array = [
  # [ "","", "不明", "0cm前後", 0, 2 ],
  # 名前　性別　サイズ　価格　user_id
  
  # ユーザー2
  [ "ヘビ","レオパードパステルモハベ", "不明", "不明", 42000, 2 ],
  [ "ヘビ","アンゴラパイソン", "不明", "60cm前後", 300000, 2 ],
  [ "ヘビ","コーンスネーク キャラメル", "不明", "20cm前後", 12800, 2 ],

  # ユーザー3
  [ "ヘビ","コーラルピンクボア", "不明", "180cm前後", 58000, 3 ],
  [ "ヘビ","コロンビアボア", "不明", "140cm前後", 60000, 3 ],
  [ "ヘビ","セントラルアメリカンボア", "不明", "140cm前後", 58000, 3 ]
]

array.each do |first, second, third, fourth, fifth, sixth|
  Reptile.create!( images: "", type1: first, type2: "", type_name: second, morph: "", sex: third, age: "1才", size: fourth, weight: "500g",
    description: "", price: fifth, sales_status: "販売中", arrival_day: "", user_id: sixth )
end
puts "success create reptile."





# 1.times do |n|
#   name  = "user-#{n+1}"
#   email = "sample#{n+1}@email.com"
#   User.create!(name: name,
#                email: email,
#                password: @password,
#                password_confirmation: @password)
# end


# Reptile.create!( image: "", type1: "ヘビ", type2: "ボールパイソン", sex: "オス", age: "5", size: "100cm", weight: "500g",
#                   description: "", price: "10000", sales_status: "販売中", arrival_day: "", user_id: "2" )
