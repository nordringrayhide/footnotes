module Footnotes
  class QueriesNote < Note

    def before
      @subscriber = ActiveSupport::Notifications.subscribe(/^sql/) do |*args|
        events << ActiveSupport::Notifications::Event.new(*args)
      end
    end

    def after
      ActiveSupport::Notifications.unsubscribe(@subscriber)
    end

    def title
      "Queries(#{ queries.length }, #{ "%.2fms" % queries.map(&:duration).sum })"
    end

    def events
      @events ||= []
    end

    def queries
      @queries ||= events.reject { |e| e.payload[:name] == 'SCHEMA' || e.payload[:sql] =~ /pg_tables|pg_attribute/ }
    end

    def render
      html = ''
      queries.each do |event|
        payload = event.payload
        name = "%s (%.1fms)" % [ payload[:name], event.duration ]
        sql = payload[:sql].squeeze(' ')
        binds = payload[:binds]

        html << "<li> #{ name } #{ event.payload[:sql] } #{ binds.blank? ? '' : binds.inspect }</li>"
      end
      "<ul>#{ html }<ul/>"
    end

  end
end
