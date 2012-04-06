require "footnotes/version"

module Footnotes

  autoload :Debugger,           'footnotes/debugger'
  autoload :Note,               'footnotes/note'
  autoload :Builder,            'footnotes/builder'
  autoload :Filter,             'footnotes/filter'

  autoload :AssignsNote,        'footnotes/notes/assigns_note'
  autoload :DurationNote,       'footnotes/notes/duration_note'
  autoload :CookiesNote,        'footnotes/notes/cookies_note'
  autoload :SessionNote,        'footnotes/notes/session_note'
  autoload :ParamsNote,         'footnotes/notes/params_note'

  autoload :NotificationsNote,   'footnotes/notes/notifications_note'

  def init
    ActionController::Base.send :around_filter, Footnotes::Filter.new
  end
  module_function :init

end
