require 'redmine'

Rails.configuration.to_prepare do
  require 'time_entry'
  TimeEntry.send(:include, TimeEntryPatch)
  # require_dependency 'timelog_controller'
  # TimelogController.send(:include, TimeEntryPatch)
end




Redmine::Plugin.register :redmine_timelog_limit do
  name 'Redmine Timelog Limit plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
