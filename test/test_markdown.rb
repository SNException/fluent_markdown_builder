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

require_relative '../lib/core/markdown.rb'
require 'minitest/autorun' 
#
# Test class for the markdown object.
#
# author:: Niklas Schultz
# version:: 0.1.0
# license:: MIT
class TestMarkdown < Minitest::Test
  def test_to_s_should_return_empty_string_if_default_initializer_is_used
    assert_equal('', Markdown.new.to_s)
  end

  def test_to_s_should_return_specified_initializer_header
    assert_equal("# Title header\n\n", Markdown.new('Title header').to_s)
  end

  def test_text_should_add_normal_text
    assert_equal('Hello World', Markdown.new.text('Hello World').to_s)
  end

  #TODO
  #def test_text_should_mask_single_format_commands
  #  assert_equal('Hello \* World', Markdown.new.text('Hello * World').to_s)
  #  assert_equal('\+ Hello World', Markdown.new.text('+ Hello World').to_s)
  #  assert_equal('Hello \` World', Markdown.new.text('Hello ` World').to_s)
  #end

  #TODO
  #def test_text_should_mask_multiple_format_commands
  #  assert_equal('Hello \*\* World', Markdown.new.text('Hello ** World').to_s)
  #  assert_equal('\+ Hello \* World', Markdown.new.text('+Hello * World').to_s)
  #end

  def test_cursive_should_add_cursive_text
    assert_equal('*Hello World*', Markdown.new.cursive('Hello World').to_s)
  end

  def test_cursive_should_remove_left_and_right_whitespaces
    assert_equal('*Hello World*', Markdown.new.cursive(' Hello World ').to_s)
  end

  def test_bold_should_add_bolded_text
    assert_equal('**Hello World**', Markdown.new.bold('Hello World').to_s)
  end

  def test_bold_should_remove_left_and_right_whitespaces
    assert_equal('**Hello World**', Markdown.new.bold(' Hello World ').to_s)
  end

  def test_bold_and_cursive_should_add_bold_cursive_text
    assert_equal('***Hello***', Markdown.new.bold_and_cursive('Hello').to_s)
  end

  def test_bold_and_cursive_should_remove_left_and_right_whitespaces
    assert_equal('***Hello World***', Markdown.new.bold_and_cursive(' Hello World ').to_s)
  end


  def test_quote_should_add_quote
    assert_equal('> Hello World', Markdown.new.quote('Hello World').to_s)
  end

  def test_horizontal_line_should_add_horizontal_line
    assert_equal("---\n\n", Markdown.new.horizontal_line.to_s)
  end

  def test_hyperlink_should_add_hyperlink
    assert_equal('[Click me](https://www.google.com "Tooltip")',
      Markdown.new.hyperlink('Click me', 'https://www.google.com', 'Tooltip').to_s
    )
  end

  def test_image_should_add_image
    assert_equal('![image_not_found](C:/imgPath "hover")', 
      Markdown.new.image('image_not_found', 'C:/imgPath', 'hover').to_s
    )
  end

  def test_ul_should_add_unorganized_list
    assert_equal("* How\n* Are\n* You\n* ?\n\n\n", Markdown.new.ul(['How', 'Are', 'You', '?']).to_s)
  end

  def test_ul_should_raise_argument_error_when_passing_incorrect_argument
    assert_raises(ArgumentError) do
      Markdown.new.ul(0)
    end
  end

  def test_ol_should_add_organized_list
    assert_equal("1. How\n2. Are\n3. You\n4. ?\n\n\n", Markdown.new.ol(['How', 'Are', 'You', '?']).to_s)
  end

  def test_ol_should_raise_argument_error_when_passing_incorrect_argument
    assert_raises(ArgumentError) do
      Markdown.new.ol(0)
    end
  end

  def test_new_line_should_add_new_line_by_adding_two_spaces
    assert_equal("Hello  \nWorld",
      Markdown.new
              .text('Hello')
              .new_line
              .text('World')
              .to_s
    )
  end

  def test_paragraph_should_add_new_paragraph
    assert_equal("Hello\n\nWorld",
      Markdown.new
              .text('Hello')
              .paragraph
              .text('World')
              .to_s
    )
  end
  
  def test_header_should_add_correct_header_level_according_to_parm
    assert_equal("# Header1\n\n", Markdown.new.header(1, 'Header1').to_s)
    assert_equal("## Header2\n\n", Markdown.new.header(2, 'Header2').to_s)
    assert_equal("### Header3\n\n", Markdown.new.header(3, 'Header3').to_s)
    assert_equal("#### Header4\n\n", Markdown.new.header(4, 'Header4').to_s)
    assert_equal("##### Header5\n\n", Markdown.new.header(5, 'Header5').to_s)
    assert_equal("###### Header6\n\n", Markdown.new.header(6, 'Header6').to_s)
  end

  def test_header_should_raise_arg_error_when_providing_bad_header_level
    assert_raises(ArgumentError) do
      Markdown.new.header(0, 'Header0?')
    end

    assert_raises(ArgumentError) do
      Markdown.new.header(7, 'Header7?')
    end
  end

  def test_code_should_add_code_format
    assert_equal('`#define TRUE FALSE`', Markdown.new.code('#define TRUE FALSE').to_s)
  end

  def test_more_complex_structure
    assert_equal(
      "# Title\n\n" +
      "---\n\n" +
      "## Sub-Title\n\n" +
      "Hello World" +
      "  \n" + 
      "Hello, again." + 
      "\n\n" +
      "bye",
      Markdown.new('Title')
              .horizontal_line
              .header(2, 'Sub-Title')
              .text('Hello World')
              .new_line
              .text('Hello, again.')
              .paragraph
              .text('bye')
              .to_s
    )
  end
end
