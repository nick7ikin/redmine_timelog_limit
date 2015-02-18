require 'redmine'

Rails.configuration.to_prepare do
  require 'time_entry'
  TimeEntry.send(:include, TimeEntryPatch)
end

Redmine::Plugin.register :redmine_timelog_limit do
  name 'Redmine Timelog Limit plugin'
  author 'Nikolay Semikin'
  description 'You can limit dates to which user is allowed to log his time'
  version '0.0.1'
  url 'https://github.com/nick7ikin/redmine_timelog_limit'

  settings :default => {}, :partial => 'settings/redmine_timelog_limit/settings'

end
