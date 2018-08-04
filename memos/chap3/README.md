# 3章のメモ

## Minitest

この本ではMinitest使う

Railsのデフォだし、Rubyに標準で入ってるし

classはTestで終わるキャメルケースで,ファイル名は最後に_test.rbつけるスネークケースでかく  

```ruby
# a,bが等しければ通る
assert_equal b, a
# aが真であれば通る
assert a
# aが偽であれば通る
refute a 
```

```bash
> ruby lib/sample_test.rb 
Run options: --seed 20903

# Running:

.   <<< これがテストの進捗状況(.1つはテスト１個なので)

Finished in 0.000975s, 1025.6410 runs/s, 1025.6410 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```