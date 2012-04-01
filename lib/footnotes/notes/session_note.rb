module Footnotes
  class SessionNote < Note

    def render
      "#{ title }: #{ controller.session.inspect }"
    end

  end
end
