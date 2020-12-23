## 要件
app/controllers/exercises_controller.rbに、exercise1~10のアクションを用意した。  
それぞれのアクション内に要件が記述してあるので、それに従ってアクションを完成させること。

### 例
```ruby
  def exerciseN
    # 【要件】 〇〇を返すこと
    @query = <<~EOS
      ※1 ここに適切な記述をする
    EOS
    @result = eval(@query.chomp)
  end
```

### 注意点
- 適切なメソッドが使われているかどうかをテストしているため、必ず※1に記述すること
- いずれの要件もワンライナー(1行)で解答できるため、※１内では改行を使わないこと

### 参考
- [Active Record クエリインターフェイス](https://railsguides.jp/active_record_querying.html)

## 始め方
1).
```terminal
$ rake db:seed
```

2).
```terminal
$ rails c
```
適宜、Railsコンソールでコマンドを試しながら適切なコードを探すこと

## テストの実行（解答の正誤の確認）
```terminal
$ bundle exec rspec spec/controllers/exercises_controller_spec.rb
```
### 期待する出力結果
[![Image from Gyazo](https://i.gyazo.com/74de5a957529ecf45065aee8e29df751.png)](https://gyazo.com/74de5a957529ecf45065aee8e29df751)


## ER図
[![Image from Gyazo](https://i.gyazo.com/18fcccec42a7905784688feebf88af91.png)](https://gyazo.com/18fcccec42a7905784688feebf88af91)