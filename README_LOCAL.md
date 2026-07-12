# ローカル(Windows)開発メモ

Cloud9から移行したローカル環境のセットアップ内容と使い方。

## 入っているもの

- Ruby 3.4.1 (RubyInstaller + DevKit) — `C:\Ruby34-x64`
- PostgreSQL 17 — `C:\Program Files\PostgreSQL\17`(サービスとして自動起動、ポート5432)
  - スーパーユーザー: `postgres` / パスワード: `postgres`
  - アプリ用DB: `s_crud`(作成済み・マイグレーション適用済み)

## 起動方法

新しいターミナル(PowerShell)でプロジェクトフォルダに移動して:

```
bundle exec ruby app.rb
```

→ http://localhost:4567 で確認できる。

## DB操作

```
bundle exec rake db:migrate     # マイグレーション実行
psqlで直接見る場合:
& "C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -h localhost s_crud
(パスワードは postgres)
```

## Cloud9との違い(重要)

- `.env` はWindowsローカル専用のDB接続情報。**Cloud9にはアップロードしない**こと
  (`config/database.yml` は環境変数が無ければ従来通りの動きをするので、Cloud9側は変更不要)。
- `db/schema.rb` はマイグレーションファイル基準で再生成済み。旧Cloud9のDBは
  マイグレーションと食い違っていた(`massages`タイポ、`price`がstring、`locker_pass`欠落)が、
  ローカルDBはマイグレーション通り(`messages` / `price` integer / `locker_pass`あり)になっている。
- Cloud9のDBに入っていたデータ(ユーザー・商品等)は移行していない(空の状態)。
- `views/layout.erb` が参照している `public/css/style.css` と `public/js/font.js` は
  ダウンロードに含まれていなかった。Cloud9側に残っていれば持ってくること。
