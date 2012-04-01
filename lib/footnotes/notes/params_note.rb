module Footnotes
  class ParamsNote < Note
    def render
      "#{ title }: #{ controller.params.inspect }"
    end
  end
end


