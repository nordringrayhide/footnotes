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

    def row; :show; end
    def slug; title.underscore; end
    def legend; title; end
    def content; render; end

    protected

    # Helpers
    def escape(text)
      text.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;')
    end

    def mount_table(array, options = {})
      header = array.shift
      return '' if array.empty?

      header = header.collect{|i| escape(i.to_s.humanize) }
      rows = array.collect{|i| "<tr><td>#{i.join('</td><td>')}</td></tr>" }

      <<-TABLE
      <table #{ hash_to_xml_attributes(options) }>
        <thead><tr><th>#{ header.join('</th><th>') }</th></tr></thead>
        <tbody>#{ rows.join }</tbody>
      </table>
      TABLE
    end

    def mount_table_for_hash(hash, options={})
      rows = []
      hash.each do |key, value|
        rows << [ key.to_sym.inspect, escape(value.inspect) ]
      end
      mount_table(rows.unshift([ 'Name', 'Value' ]), { :class => 'name_value' }.merge(options))
    end

    def hash_to_xml_attributes(hash)
      newstring = ""
      hash.each do |key, value|
        newstring << "#{ key.to_s }=\"#{ value.gsub('"','\"') }\" "
      end
      newstring
    end
  end
end
