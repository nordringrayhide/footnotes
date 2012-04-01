require 'rails/engine'

module Footnotes
  class Engine < Rails::Engine
    config.footnotes = ActiveSupport::OrderedOptions.new

    initializer 'footnotes' do
    end

    ActiveSupport.on_load(:active_record) do
    end

  end
end
