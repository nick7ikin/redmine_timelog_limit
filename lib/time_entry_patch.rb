
module TimeEntryPatch

  def self.included(base) # :nodoc:

    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      validate :check_limit

      protected
      def check_limit
        time_entry_date = spent_on
        num_of_days = Date.today - time_entry_date
        timelog_limit = TimelogLimit.timelog_days_auto_offset_limit
        if num_of_days > timelog_limit && !User.current.admin?
          errors.add :spent_on, "you can't log later then #{timelog_limit} days"
        end
      end
    end

  end

end
