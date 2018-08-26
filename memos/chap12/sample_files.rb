# カレントディレクトリ(実行場所から見た)にファイルが存在するか
puts File.exists?('./README.md') # => true

# カレントディレクトリにフォルダが存在するか
puts Dir.exists?('./sample_folder') # => true

# ファイルを読み込んで行数を表示
File.open('./lib/fizz_buzz.rb', 'r') do |f|
  puts f.readlines.count
end

# 書き込み
#File.open('sample.txt', 'w') do |f|
#  f.puts 'Hello'
#end

# パス名をオブジェクト指向っぽく扱う
require 'pathname'

lib = Pathname.new('./lib')

# ファイル？
puts lib.file? # => false

# ディレクトリ?
puts lib.directory? # => true

# パスを文字列に
puts lib.join('sample.txt').to_s # =>./lib/sample.txt
