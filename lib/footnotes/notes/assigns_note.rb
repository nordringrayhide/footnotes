module Footnotes
  class AssignsNote < Note

    def render
      mount_table(to_table, :summary => "Debug information for #{ title }")
    end

    protected

    def to_table
      @to_table ||= (assigns - ignored_assigns).inject([]) {|rr, var| rr << [var, escape(assigned_value(var))]}.unshift(['Name', 'Value'])
    end

    def assigns
      @assigns ||= controller.instance_variables.map { |v| v.to_sym }
    end

    def ignored_assigns
      @ignored_assigns ||= controller.instance_variables.select { |v| v.to_s =~ /^@_/ }
    end

    def assigned_value(key)
      controller.instance_variable_get(key).inspect
    end

  end
end
