# 10章(yield, Proc)

## yield?

ブロック付きで呼ばれた時にブロックの処理を呼び出す

yield_sample.rbを参照

## 明示的なブロック引数

```Ruby
# &はブロック引数
def メソッド(&引数)
  引数.call
end
```

注意点

* ブロック引数はメソッド定義につき１つのみ
* 他の引数がある時は必ず最後に指定する

## yieldは何が嬉しい?

* ブロックを他のメソッドに引き渡せれる
* arityなど、ブロック引数の数に応じた処理もかけたりする

## Proc

処理のかたまりであるはずのブロックをオブジェクト化するためのクラス  
Procはつまり「手続き」のクラス

proc_sampleを参考

Procはブロックのオブジェクトなので、ブロック引数に渡したりもできる

## Procの生成方法

* `Proc.new`
* `proc { ... }`
* lambda構文 `->(a, b) { a + b }`
* `lambda { |a, b| a + b }`

## Procをもう少し詳しく

call以外にProcを呼ぶ方法

other_proc.rb

atomを使ってもっとシンプルにできるかくにん

```ruby
['ruby', 'java', 'perl'].map { |s| s.upcase }
['ruby', 'java', 'perl'].map(&:upcase)
# &:upcase は:upcaseに対してto_procを呼ぶ
# つまりmapにProc(ブロック)が渡されることになる map { upcase }
# 配列の各要素がレシーバーとして渡される 
```

## Procとクロージャー

```ruby
def generate_proc(array)
  counter = 0
  Proc.new do
    counter += 10
    array << counter
  end
end

values = []
sample_proc = generate_proc(values)
puts values # => []

sample_proc.call
puts values # => [10]

sample_proc.call
puts values # => [10, 20]
```

メソッド生成時にコンテキストを保持しているメソッド  
クロージャーっていうよ(変数の参照範囲を超えてアクセスできる)




