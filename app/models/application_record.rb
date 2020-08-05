class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  # debug_log
  def debug_log(argument)
    Rails.application.config.another_logger.debug(argument)
  end
end
