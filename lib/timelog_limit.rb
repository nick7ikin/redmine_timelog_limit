
module TimelogLimit

  DEFAULT_DAYS_LIMIT = 31   #  it's ~1 month

  class << self

    def timelog_days_auto_offset_limit
      by_settigns = Setting.plugin_redmine_timelog_limit['timelog_days_auto_offset_limit'].to_i
      by_settigns > 0 ? by_settigns : DEFAULT_DAYS_LIMIT
    end

    def timelog_manual_global_date_limit_string
      Setting.plugin_redmine_timelog_limit['timelog_manual_global_date_limit'].to_s
    end

    def timelog_manual_global_date_limit_date
      Setting.plugin_redmine_timelog_limit['timelog_manual_global_date_limit'].to_s.to_date
    end

    def active_users_without_exceptional
      exceptional_ids = exceptional_user_ids
      without_exceptional = User.active.sorted.reject { |user| exceptional_ids.include?(user.id) }
      users_to_select_field_options(without_exceptional)
    end

    def exceptional_users_hash
      exceptional_ids = User.find(exceptional_user_ids)
      users_to_select_field_options(exceptional_ids)
    end

    def exceptional_user_ids
      user_ids = []
      exceptional_users_id_string.split(",").each { |user_id| user_ids.push(Integer(user_id))}
      user_ids
    end

    def exceptional_users_id_string
      Setting.plugin_redmine_timelog_limit['exclusive_users'].to_s
    end


    protected
    def users_to_select_field_options(users)
      users_hash = {}
      users.each { |user|
        users_hash[user.name] = user.id
      }
      users_hash
    end

    def exceptional_users
      User.find(exceptional_user_ids)
    end

  end

end
