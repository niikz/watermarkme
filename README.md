# Watermark Me
<img width="600" alt="Watermark Me" src="https://user-images.githubusercontent.com/60736158/211139917-96850481-b6b1-45d9-82af-b9c959792a41.png">

https://watermarkme.fly.dev/

## 概要
Watermark Meは、画像にアカウント名の透かしを入れて投稿できるツイート投稿サービスです。

Twitterアカウントさえあれば使えます。
透かしを入れた画像をダウンロードせずにTwitterへ投稿できる機能が特徴です。

## 開発環境
- Ruby 3.1.2
- Ruby on Rails 6.1.7
- Vue.js 3.2.36

## 利用方法
### 環境変数の設定
| 環境変数名         | 説明                   | 
| ------------------ | ---------------------- | 
| twitter_api_key    | Twitter API Key        | 
| twitter_api_secret | Twitter API Key Secret |

### インストール
```shell
$ bin/setup
$ foreman start
```

### Test
```shell
$ bin/rails test
```

### Lint
```shell
$ bin/lint
```
