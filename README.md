# Fluent Markdown Builder

The fluent markdown builder is a ruby gem which provides a fluent interface
for creating markdown content.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent_markdown_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent_markdown_builder

## Usage

This gem only has one file intended to be used by the client: The Markdown.rb

You can simply create an object from this class and start building your markdown
content like the following example demonstrates:

```ruby
md = Markdown.new('The fluent markdown builder gem')
             .text('This is a gem which allows you to generate markdown syntax')
             .text(' via a fluent builder pattern.')
             .new_line
             .text('Let\'s show some more functionality')
             .new_line
             .header(2, 'Lists')
             .text('There are two type of lists:')
             .paragraph
             .bold('Organized lists:')
             .new_line
             .ol(['Some item', 'Another item', 'And yet another item'])
             .bold('Unorganized lists:')
             .new_line
             .ul(['More items!', 'And even more', '...'])
             .header(2, 'Hyperlinks')
             .cursive('You can also add hyperlinks:')
             .new_line
             .hyperlink('Link to google', 'https://www.google.com', 'Take me to google')
             .paragraph
             .header(2, 'Code')
             .text('We can also add code snippets')
             .new_line
             .code('#define 1 0')
             .paragraph
             .horizontal_line
             .cursive('I think that should be enough for a short demo')
             .new_line
             .quote('Have a nice day')
             .to_s
```

Now you can write the (string) content into a file for example and display it in
a markdown viewer.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags.

## Contributing

Bug reports and pull requests are very welcome and highly appreciated 
on GitHub at https://github.com/SNException/fluent_markdown_builder.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
