module Footnotes
  class SessionNote < Note

    def render
      mount_table_for_hash(controller.session.to_hash, :summary => "Debug information for #{ title }")
    end

  end
end
