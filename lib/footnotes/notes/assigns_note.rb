module Footnotes
  class AssignsNote < Note

    def after
      @assign_names = controller.instance_variables.reject { |v| v.to_s =~ /^@_/ }.map(&:to_sym)
    end

    def render
      "#{ title }: #{ @assign_names.map { |assign_name| "#{ assign_name.to_s.gsub(/^@/, '') }: #{ escape(controller.instance_variable_get(assign_name).inspect) }" } }"
    end

  end
end
