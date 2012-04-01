module Footnotes
  module Debugger
    def say(message)
      Rails.logger.info(message)
    end
  end
end
