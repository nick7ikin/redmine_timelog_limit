
module TimeEntryPatch

  def self.included(base) # :nodoc:

    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      validate :check_limit

      protected
      def check_limit
        isExclusiveUser = TimelogLimit.exceptional_user_ids.include?(User.current.id)
        if isExclusiveUser
          return
        end

        check_day_offset_limit
        check_date_limit
      end

      def check_date_limit
        limit_date = TimelogLimit.timelog_manual_global_date_limit_date
        if limit_date.nil?
          return
        end
        time_entry_date = spent_on
        days_since_date_limit = time_entry_date - limit_date
        if days_since_date_limit < 0
          # errors.add :spent_on, "you can't log before #{limit_date}"
          error_str = l(:must_be_after) + TimelogLimit.timelog_manual_global_date_limit_date
          errors.add :spent_on, l(error_str)
        end
      end

      def check_day_offset_limit
        time_entry_date = spent_on
        num_of_days = Date.today - time_entry_date
        timelog_limit = TimelogLimit.timelog_days_auto_offset_limit
        if num_of_days > timelog_limit && !User.current.admin?
          error_str = l(:must_be_closer_to_the_current_day) + timelog_limit.to_s
          errors.add :spent_on, "you can't log later then #{timelog_limit} days"
        end
      end
    end

  end

end
