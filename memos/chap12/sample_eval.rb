code = '[1,2,3].map { |n| n * 10 }'
puts eval(code)

# バッククォートで囲んだものはOSコマンドとして利用できる
puts `cat ./README.md`

# sendはレシーバーに対して、渡した文字列orシンボルのメソッドを実行する
str = 'a,b,c'
puts str.send('upcase')
puts str.send(:upcase)