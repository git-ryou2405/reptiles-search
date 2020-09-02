# ルート
crumb :root do
  link "HOME", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", user_path
  parent :search_page
end

# マイページ内_レプタイル検索
crumb :shop_reptile_search do
  if current_page?(:controller => 'users', :action => 'show')
    if params[:current_reptile_type].present?
      link params[:current_reptile_type]
    end
  end
parent :mypage
end

# 全国生体一覧
crumb :search_page do
  @reptile_type = "ヘビ"
  link "全国サーチ", search_page_path(Reptile, type1: @reptile_type, searchtype: "ctg_btn" )
end

# ショップページ
crumb :shop_page do
  link "ショップページ", shop_page_path
  parent :search_page
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
