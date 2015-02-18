
module TimeEntryPatch

  def self.included(base) # :nodoc:

    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      validate :check_limit

      protected
      def check_limit
        time_entry_date = spent_on
        num_of_days = Date.today - time_entry_date
        if num_of_days > 3 && !User.current.admin?
          errors.add :spent_on, "you can't log later then 3 days"
        end
      end
    end

  end

end
