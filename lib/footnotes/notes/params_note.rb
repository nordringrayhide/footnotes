module Footnotes
  class ParamsNote < Note
    def render
      mount_table_for_hash(controller.params, :summary => "Debug information for #{ title }")
    end
  end
end


