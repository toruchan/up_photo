crumb :root do
  link "Home", root_path
end

crumb :image_category do |image_category|
  link image_category.name, images_path(image_category.id)
  parent :root
end

crumb :illustration_category do |illustration_category|
  link illustration_category.name, illustrations_path(illustration_category.id)
  parent :root
end

crumb :movie_category do |movie_category|
  link movie_category.name, movies_path(movie_category.id)
  parent :root
end

crumb :image_tag do |breadcrumbs|
  link breadcrumbs['tag'].name, "images/tag?tag_id=#{breadcrumbs['tag'].id}"
  if breadcrumbs['category'].present?
    parent :image_category, breadcrumbs['category']
  end
end

crumb :illustration_tag do |breadcrumbs|
  link breadcrumbs['tag'].name, "illustrations/tag?tag_id=#{breadcrumbs['tag'].id}"
  if breadcrumbs['category'].present?
    parent :illustration_category, breadcrumbs['category']
  end
end

crumb :movie_tag do |breadcrumbs|
  link breadcrumbs['tag'].name, "movies/tag?tag_id=#{breadcrumbs['tag'].id}"
  if breadcrumbs['category'].present?
    parent :movie_category, breadcrumbs['category']
  end
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
