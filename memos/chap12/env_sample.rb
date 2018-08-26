my_name = ENV['MY_NAME']

email = ARGV[0]
age = ARGV[1]

puts my_name
puts email
puts age

# $ export MY_NAME="esaka"
# $ ruby env_sample.rb hoge@hoge.com 12
# =>
# esaka
# hoge@hoge.com
# 12

# 組み込み変数

puts RUBY_VERSION # => 2.5.1