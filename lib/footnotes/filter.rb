module Footnotes

  class Filter
    @@note_classes = [ AssignsNote, DurationNote, SessionNote, ParamsNote, CookiesNote, NotificationsNote, QueriesNote ]
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

      # controller.response.body += <<-HTML
      #   <div id="footnotes">
      #     #{ @notes.map { |note| "<div class='footnotes-note'> #{ note.render } </div>" }.join }
      #   </div>
      # HTML

      @builder = Builder.new(controller, @notes)
      say "#{ controller.params[:footnotes] }"
      if controller.params[:footnotes].to_s.downcase != 'false'
        @builder.inject!
      else
        say 'footnotes skipped'
      end

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
