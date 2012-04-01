module Footnotes

  class Filter
    @@note_classes = [AssignsNote, DurationNote, SessionNote, ParamsNote, CookiesNote]
    include Debugger

    def initialize
      @notes = []
    end

    def before(controller)
      @time = Time.now

      @notes = @@note_classes.map { |klass| klass.new(controller) }

      @notes.each(&:before)

      say 'Footnotes before filter ...'
      true
    end

    def after(controller)
      @notes.each(&:after)

      controller.response.body += <<-HTML
        <div id="footnotes">
          <div class="footnotes-note"> #{ @notes.map(&:render).join('<br/>') } </div>
        </div>
      HTML

      say "Duration: #{ Time.now - @time } sec"
      say 'Footnotes after filter'

      true
    end

    def self.note_classes=(classes)
      @@note_classes = classes
    end

    def self.note_classes
      @@note_classes
    end

    protected
  end
end
