## 要件
exercises_controllerに定義された各アクションを完成させなさい。
### 注意点
- 既に記述している箇所は変更しないこと。
  - 適切なクラスに適切なメソッドが呼び出され適切なインスタンス変数に格納されることをテストしています。

### 参考資料
- [Active Record クエリインターフェイス](https://railsguides.jp/active_record_querying.html)

## 始め方
1).  
```terminal
$ rake db:seed
$ rake db:seed RAILS_ENV=test
```
上記の各コマンドは実行終了まで10~15秒くらいかかることがあります。  

2).  
```terminal
$ rails c
```
適宜、Railsコンソールでコマンドを試しながら適切なコードを探すこと。  

## テストの実行（解答の正誤の確認）
```terminal
$ bundle exec rspec spec/controllers/exercises_controller_spec.rb
```
## ER図
[![Image from Gyazo](https://i.gyazo.com/47095be0fe0f60ade0e0cdf95860ba33.png)](https://gyazo.com/47095be0fe0f60ade0e0cdf95860ba33)