module Footnotes
  class CookiesNote < Note
    def render
      "#{ title }: #{ controller.request.cookies.inspect }"
    end
  end
end
