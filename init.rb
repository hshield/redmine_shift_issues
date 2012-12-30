require 'redmine'

require_dependency 'hooks/issue_hooks'

Redmine::Plugin.register :redmine_shift_issues do
  name 'Shift Issues plugin'
  author 'Indrajaya Lie'
  description 'Shift issues forward / backward'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
