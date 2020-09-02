# ルート
crumb :root do
  link "HOME", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", user_path
  parent :alljapan_page
end

# マイページ内_レプタイル選択リスト
crumb :mypage_reptile_list do
  link params[:current_reptile_type]
  parent :mypage
end

# マイページ内_レプタイル選択リスト-->選択レプタイル
crumb :mypage_reptile_list_select do
  @select_reptile = Reptile.find(params[:current_select])
  link @select_reptile.type1, user_path(current_user, current_reptile_type: @select_reptile.type1)
  parent :mypage
end

# マイページ内_レプタイル検索
crumb :mypage_select_reptile do
  @select_reptile = Reptile.find(params[:current_select])
  link @select_reptile.type_name
  parent :mypage_reptile_list_select
end

# 全国サーチ
crumb :alljapan_page do
  @reptile_type = "ヘビ"
  link "全国サーチ", alljapan_page_path(type1: @reptile_type, searchtype: "ctg_btn" )
end

# 全国サーチ_レプタイル選択リスト
crumb :alljapan_reptile_list do
  link params[:type1]
  parent :alljapan_page
end

# 全国サーチ_レプタイル選択リスト-->選択レプタイル
crumb :alljapan_reptile_list_select do
  @select_reptile = Reptile.find(params[:id])
  link @select_reptile.type1, alljapan_page_path(type1: @select_reptile.type1, searchtype: "ctg_btn" )
  parent :alljapan_page
end

# 全国サーチ_選択レプタイル
crumb :alljapan_select_reptile do
  @select_reptile = Reptile.find(params[:id])
  link @select_reptile.type_name
  parent :alljapan_reptile_list_select
end

# ショップページ
crumb :shop_page do
  @disp_shopinfo = User.find(params[:shop_id])
  link @disp_shopinfo.shop_name, shop_page_path(shop_id: params[:shop_id])
  # link "ショップページ", shop_page_path(shop_id: params[:shop_id])
  parent :alljapan_page
end

# ショップページ_レプタイル選択リスト
crumb :shop_reptile_list do
  link params[:type1]
  parent :shop_page
end

# ショップページ_レプタイル選択リスト-->選択レプタイル
crumb :shop_reptile_list_select do
  @select_reptile = Reptile.find(params[:reptile_id])
  link @select_reptile.type1, shop_page_path(type1: @select_reptile.type1, shop_id: @select_reptile.user_id)
  parent :shop_page
end

# ショップページ_選択レプタイル
crumb :shop_select_reptile do
  @select_reptile = Reptile.find(params[:reptile_id])
  link @select_reptile.type_name
  parent :shop_reptile_list_select
end



# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
