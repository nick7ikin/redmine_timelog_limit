
module TimeEntryPatch

  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method_chain :create, :check_limit
    end
  end

  module InstanceMethods

    def create_with_check_limit

      begin
        time_entry_date = params[:time_entry][:spent_on].to_s.to_date
      rescue
        raise "invalid_date_error"
      end

      num_of_days = Date.today - time_entry_date
      if num_of_days < 3
        return create_without_check_limit
      end

      @user = User.current
      if @user.admin?
        return create_without_check_limit
      end

      raise "you are not allowed to log time later than 3 days"

    end

  end

end

