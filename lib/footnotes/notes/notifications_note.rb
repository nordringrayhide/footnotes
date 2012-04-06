module Footnotes
  class NotificationsNote < Note

    def before
      @subscriber = ActiveSupport::Notifications.subscribe(/.*/) do |*args|
        (@events ||= []) << ActiveSupport::Notifications::Event.new(*args)
      end
    end

    def after
      ActiveSupport::Notifications.unsubscribe(@subscriber)
    end

    def render
      html = ''
      @events.each do |event|
        html << "<li>#{ event.name }(#{ event.duration }) - #{ event.payload.inspect }</li>"
      end
      "<ul> #{ html } </ul>"
    end

  end
end

