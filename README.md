# Footnotes

Flexible Rails GUI based debugging helper 

## Installation

Add this line to your application's Gemfile:

    gem 'footnotes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install footnotes

## Usage

config/initializers/footnotes.rb

```ruby
Footnotes.init
```

## Stylesheets

app/assets/application.css

```css
#footnotes {
  font-family: Verdana, sans;
  font-size: 11px;
  border-top: 1px solid #bbb;
  padding-top: 10px;
}
```

## Custom notes

config/initializers/footnotes.rb

```ruby
module Footnotes
  class CurrentUserNote < Note
    def render
      "#{ title }: #{ controller.current_user.full_name }"
    end
  end
end

Footnotes::Filter += [ CurrentUserNote ]
```

Enjoi!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

(c) 2012 Roman V. Babenko <romanvbabenko@gmail.com>
