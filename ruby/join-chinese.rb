#!/usr/bin/env ruby
#encoding: UTF-8

# Requires ruby 1.9.x, and assumes UTF-8 encoding

class String
  # The regular expression trick to match CJK characters comes from
  # http://stackoverflow.com/a/4681577/306935
  # For more info on the regex used here, refer to http://oniguruma.rubyforge.org/svn/Syntax.txt
  # And for Unicode Character Categories http://www.fileformat.info/info/unicode/category/index.htm
  # Unfortunately, we don't have a specific category to specify Chinese
  # punctuations, so I have to list them manually. (Not complete, just the most
  # common ones here.)
  han = '\p{Han}|[，。？；：‘’“”、！……（）]'
  @@chinese_regex = /(#{han}) *\n *(#{han})/m
  def join_chinese
    gsub(@@chinese_regex, '\1\2')
  end
  def join_chinese!
    gsub!(ChineseRegex, '\1\2')
  end
end

if ARGV.size != 1
  puts "Usage: #{File.basename $0} <file>"
  exit 1
end

print IO.read(ARGV[0]).join_chinese

