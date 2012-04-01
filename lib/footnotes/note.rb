module Footnotes
  class Note
    attr_reader :controller

    def initialize(controller)
      @controller = controller
    end

    def before; end;
    def after; end;

    def title
      self.class.name.to_s.demodulize.gsub(/Note$/, '')
    end

    def render
      "#{ title }: ..."
    end

    protected

    # Helpers
    #TODO Rails tags usage ?
    def escape(text)
      text.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;')
    end
  end
end
