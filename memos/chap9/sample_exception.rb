puts 'Start.'
module Greeter
  def hello
    'hello'
  end
end

# 例外処理
begin
  greeter = Greeter.new
rescue
  puts '例外が発生したが処理を継続'
end

puts 'End.'
