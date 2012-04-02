module Footnotes
  class CookiesNote < Note
    def render
      mount_table_for_hash(controller.request.cookies.to_hash, :summary => "Debug information for #{ title }")
    end
  end
end
