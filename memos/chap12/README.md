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

## gemとBundler

Rubyのライブラリはgemという形式  
RubyGems.orgにアップロードされる

```bush
$ gem install <ライブラリ名>
# バージョン指定も可能
$ gem install <ライブラリ名> -v <バージョン>
```

rbenvなど使っている場合は使っているrubyのバージョンごとにインストールが必要になる

### Bundler

複数のgemは依存関係を持っているのが多い、大規模プロジェクトだと
ライブラリのバージョン管理がきつくなってくる
それらを管理するのがbundler

```bash
$ bundle init
# => Gemfileが作られる
# Gemfileに必要なライブラリを記載して
$ bundle install
# => 必要なライブラリがインストールされる
# bundle execに続いてコマンドを打つと,bundle管理のライブラリを含めた状態で動いてくれる
$ irb
>> require 'faker'; Faker::VERSION
=> "1.9.1"
$ bundle exec irb
>> require 'faker'; Faker::VERSION
=> "1.7.2"
# 別バージョンで管理されているのがわかる
```

ちなみに自動で生成されるGemfile.lockはバージョンなどの依存関係を記述したもので  
bundlerが自動で作るので、開発者は勝手にいじってはだめ

#### bundlerのバージョン記法

最新がインストール  
`gem 'faker'`

固定のバージョン  
`gem 'faker', '1.7.2'`

1.7.2以上  
`gem 'faker', '>= 1.7.2'`

1.7.2以上かつ1.8未満(バッチバージョンのアップデートのみ許可)  
`gem 'faker', '~> 1.7.2`

1.7以上かつ、2.0未満(マイナーバージョンアップのみ許可)  
`gem 'faker', '~> 1.7'`