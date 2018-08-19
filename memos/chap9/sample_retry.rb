retry_count = 0
begin
  puts '例外処理です'
  1 / 0 # ZeroDivision
rescue
  retry_count += 1
  if retry_count <= 3
    puts "retryします (#{retry_count}回目)"
    retry
  else
    puts 'retryしても失敗だったよ'
  end
end
