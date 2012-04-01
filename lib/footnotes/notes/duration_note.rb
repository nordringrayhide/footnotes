module Footnotes
  class DurationNote < Note

    def before
      @time = Time.now
    end

    def after
      @duration = Time.now - @time
    end

    def render
      "#{ title }: #{ @duration }"
    end

  end
end

