# MIT License
#
# Copyright 2019 Niklas Schultz.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# The Markdown object.
# All its methods (with the exception of to_s) return 'self'.
# That way you can use this object as fluent builder to create your
# Markdown content.
#
# author:: Niklas Schultz
# version:: 0.1.0
# license:: MII
class Markdown
  # Creates a new object.
  #
  # You can ignore the argument so no header will be added on construction of
  # this object.
  def initialize(h1 = '')
    @md = ''
    unless h1.empty? then header(1, h1) end
   end

  # Adds a string to the current content.
  def text(txt)
    @md += txt
    self
  end

  # Adds a header to the markdown content.
  #
  # The first argument specifies the header level (h1, h2...h6).
  def header(level, txt)
    raise ArgumentError, 'header level must not be 0 or smaller' if level <= 0
    raise ArgumentError, 'header level must not be greater than 6' if level > 6

    hashes = ''
    level.times do
      hashes += '#'
    end
    text(hashes + ' ' + txt)
    paragraph
  end

  # Adds a horizontal line.
  def horizontal_line
    text('---')
    paragraph
  end

  # Adds text which is cursive.
  def cursive(txt)
    text('*' + txt.rstrip.lstrip + '*')
  end
  
  # Adds text which is bold.
  def bold(txt)
    text('**' + txt.rstrip.lstrip + '**')
  end

  # Adds text which is both bold and cursive.
  def bold_and_cursive(txt)
    text('***' + txt.rstrip.lstrip + '***')
  end
  
  # Adds a quote.
  def quote(txt)
    text('> ' + txt)
  end

  # Adds a line of code.
  def code(txt)
    text('`' + txt + '`')
  end

  # Adds an unorganized list out of the given array.
  def ul(bullet_points)
    unless bullet_points.respond_to?(:each)
      raise ArgumentError, 'arg must respond to "each" call'
    end

    md_list = ''
    bullet_points.each do |v|
      md_list += '* ' + v + line_feed
    end
    text(md_list)
    paragraph
  end

  # Adds an organized list out of the given array.
  def ol(bullet_points)
    unless bullet_points.respond_to?(:each_with_index)
      raise ArgumentError, 'arg must respond to "each_width_index" call'
    end

    md_list = ''
    bullet_points.each_with_index do |v, i|
      md_list += (i + 1).to_s + '. ' + v + line_feed
    end
    text(md_list)
    paragraph
  end

  # Adds a hyperlink.
  #
  # This method takes three arguments:
  # 1. The description of the hyperlink (the actual text shown)
  # 2. The target of the hyperlink (e.g. https://google.com)
  # 3. The text which will be displayed if you hover over the link
  def hyperlink(desc, target, hover)
    text('[' + desc + ']' + '(' + target + ' ' + '"' + hover + '"' + ')')
  end

  # Adds an image.
  #
  # This method takes three arguments:
  # 1. The alternative text displayed if no image could be loaded
  # 2. The path/resource of the image (e.g on your file system)
  # 3. The text which will be displayed if you hover over the image
  def image(alternative, path, hover)
    text('![' + alternative + ']' + '(' + path + ' ' + '"' + hover + '"' + ')')
  end

  # Adds a new (empty) line.
  def new_line
    two_spaces = '  '
    text(two_spaces + line_feed)
  end

  # Adds a new paragraph.
  def paragraph
    text(line_feed + line_feed)
  end

  # Converts this object to a string.
  #
  # In other words this method should be the final call you should invoke when
  # you done creating the markdown content. After this call you can use the
  # produced string and show it in a markdown viewer for example.
  def to_s
    @md
  end

  private

  def line_feed
    "\n"
  end
end
