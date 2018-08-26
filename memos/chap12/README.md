# 12章 Rubyその他
 
## 日付型

* Timeクラス
* Dateクラス
* DateTimeクラスの３つがある

TimeとDateTimeはほとんど同じ  
Timeクラスはrequireなしで使えるのでその分使い勝手がいい  
またTimeはサマータイムやうるう秒も扱える

## ファイルやディレクトリの扱い

* Fileクラス
* Dirクラス
* FileUtilesクラス
* Pathnameクラス

## 環境変数

ワンライナー実行

`-e`で渡せばワンライナーで実行できる

```bash
$ ruby -e 'p [65,66,67].map(&:chr).join'
"ABC"
```

## eval

文字列をRubyコマンドとして実行したり

## コードレビュー

Brakemanとかを使えばコード解析をして、セキュリティ的に問題のあるコードを指摘してくれる

RuboCopでは標準コーディングルールに準拠しているかを確認してくれる

RubyCriticではコードの複雑さや無駄が内科を確認してくれる

## Rake

Rubyのビルドツール  
ビルドだけでなくまとまった処理をやるのに使われる

Rubyを DSLに使う

