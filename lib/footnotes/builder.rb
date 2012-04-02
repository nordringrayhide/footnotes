module Footnotes
  class Builder
    attr_reader :controller, :notes
    @@multiple_notes = false

    def initialize(controller, notes)
      @controller, @notes = controller, notes
    end

    def inject!
      insert_styles
      insert_footnotes
    end

    # Helpers
    def links
      links = Hash.new([])
      order = []
      each_with_rescue(@notes) do |note|
        order << note.row
        links[note.row] += [link_helper(note)]
      end

      html = ''
      order.uniq!
      order.each do |row|
        html << "#{ row.is_a?(String) ? row : row.to_s.camelize }: #{ links[row].join(" | \n") }<br />"
      end
      html
    end

    def link_helper(note)
      href = '#'
      onclick ||= "Footnotes.hideAllAndToggle('#{ note.title.underscore.gsub(/_note$/, '') }_debug_info'); return false;"

      "<a href=\"#{href}\" onclick=\"#{ onclick }\">#{ note.title }</a>"
    end

    def fieldsets
      content = ''
      each_with_rescue(@notes) do |note|
        content << <<-HTML
          <fieldset id="#{ note.slug }_debug_info" style="display: none">
            <legend>#{ note.legend }</legend>
            <div>#{ note.content }</div>
          </fieldset>
        HTML
      end
      content
    end

    def close
      javascript = ''
      each_with_rescue(@notes) do |note|
        javascript << close_helper(note)
      end
      javascript
    end

    def close_helper(note)
      "Footnotes.hide(document.getElementById('#{ note.slug }_debug_info'));\n"
    end

    def insert_footnotes
      content = fieldsets

      footnotes_html = <<-HTML
      <!-- Footnotes -->
      <div style="clear:both"></div>
      <div id="footnotes_debug">
        #{ links }
        #{ content }
        <script type="text/javascript">
          var Footnotes = function() {

            function hideAll() { #{ close unless @@multiple_notes } }

            function hideAllAndToggle(id) { hideAll(); toggle(id)
              location.href = '#footnotes_debug'; }

            function toggle(id) {
              var el = document.getElementById(id);
              if (el.style.display == 'none') { Footnotes.show(el); } else { Footnotes.hide(el); } }

            function show(element) { element.style.display = 'block' }

            function hide(element) { element.style.display = 'none' }

            return { show: show, hide: hide, toggle: toggle, hideAllAndToggle: hideAllAndToggle }
          }();
          /* Additional Javascript */
        </script>
      </div>
      <!-- End Footnotes -->
      HTML

      placeholder = /<div[^>]+id=['"]footnotes_holder['"][^>]*>/i
      if @controller.response.body =~ placeholder
        insert_text :after, placeholder, footnotes_html
      else
        insert_text :before, /<\/body>/i, footnotes_html
      end
    end

    def insert_text(position, pattern, new_text)
      index = case pattern
        when Regexp
          if match = @controller.response.body.match(pattern)
            match.offset(0)[position == :before ? 0 : 1]
          else
            @controller.response.body.size
          end
        else
          pattern
        end
      newbody = @controller.response.body
      newbody.insert index, new_text
      @controller.response.body = newbody
    end

    def insert_styles
      insert_text :before, /<\/head>/i, <<-HTML
      <!-- Footnotes Style -->
      <style type="text/css">
        #footnotes_debug {font-size: 13px; font-weight: normal; margin: 2em 0 1em 0; text-align: center; color: #444; line-height: 16px;}
        #footnotes_debug th, #footnotes_debug td {color: #444; line-height: 18px;}
        #footnotes_debug a {color: #9b1b1b; font-weight: inherit; text-decoration: none; line-height: 18px;}
        #footnotes_debug table {text-align: center;}
        #footnotes_debug table td {padding: 0 5px;}
        #footnotes_debug tbody {text-align: left;}
        #footnotes_debug .name_values td {vertical-align: top;}
        #footnotes_debug legend {background-color: #fff;}
        #footnotes_debug fieldset {text-align: left; border: 1px dashed #aaa; padding: 0.5em 1em 1em 1em; margin: 1em 2em; color: #444; background-color: #FFF;}
        /* Aditional Stylesheets */
      </style>
      <!-- End Footnotes Style -->
      HTML
    end

    protected
    def each_with_rescue(collection, &block)
      collection.each { |item| block.call(item) }
    end
  end
end
