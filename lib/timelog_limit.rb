
module TimelogLimit

  DEFAULT_DAYS_LIMIT = 31   #  it's ~1 month

  class << self
    def timelog_days_auto_offset_limit
      by_settigns = Setting.plugin_redmine_timelog_limit['timelog_days_auto_offset_limit'].to_i
      by_settigns > 0 ? by_settigns : DEFAULT_DAYS_LIMIT
    end

  end

end
