# twi-note <a href="https://twitter.com/intent/tweet?url=https%3A%2F%2Fgithub.com%2Fs4na%2Ftwi-note&text=%E5%8B%89%E5%BC%B7%E4%BC%9A%E6%94%AF%E6%8F%B4%E3%82%A2%E3%83%97%E3%83%AA%E3%80%8C%E3%81%A4%E3%81%84%E3%83%8E%E3%83%BC%E3%83%88%E3%80%8D&via=s4na_penguin&hashtags=#twi-note" target="_blank">![Tweet](https://img.shields.io/twitter/url/http/shields.io.svg?style=social&logo=twitter)</a>

勉強会参加者向けのノート作成支援アプリ

[![](https://github.com/s4na/twi-note/workflows/build/badge.svg)](https://github.com/s4na/twi-note/actions)
[![Percentage of issues still open](http://isitmaintained.com/badge/open/s4na/twi-note.svg)](http://isitmaintained.com/project/s4na/twi-note "Percentage of issues still open")

[![twi-note-logo](./app/assets/images/twi-note-icon/icon-196x196.png)](https://twi-note.herokuapp.com/)

## サイトリンク

https://twi-note.herokuapp.com/

## アプリケーションについて
### はじめに
今回は勉強会参加者向けのノート作成支援アプリである「ついノート」を作成しました。
以下ではその背景とアプリの概要について説明します。

### 背景
エンジニアは最新の知識を得るために日々情報収集を行っています。
その手法は様々ですが、勉強会への参加は直接現場のエンジニアからの話や意見を聞くことができる点で効果的です

一方で、勉強会参加の意義を高めるために、情報を整理・集約・定着させる必要があり、そこにはいくつかの課題があります。特に知識の集約を容易にすることは重要だと考えられます。

そこで今回は、知識を整理・集約するのを助けてくれる「ついノート」を作成しました。

### アプリケーションの概要

ついノートは「勉強会ハッシュタグ」「開始時間」「終了時間」を入力するだけで、簡単にツイートをまとめることができます。
これまでは勉強会参加者が個別にノートを作成しなければいけなかったところを、
ついノートを用いるとツイートをまとめるのみで済むようになります。

## インストール

```
$ bin/setup
$ rails server
```

## セットアップ

```
$ ./bin/setup
```

### 環境変数のセット（テストでは不要）

- TWITTER_APP_ID = Twitter API ID
- TWITTER_APP_SECRET = Twitter API Secret

## テスト

ヘッドレスブラウザテスト

```
$ ./bin/test
```

普通のブラウザでテスト

```
$ HEADED=1 ./bin/test
```

## Lint

rubocop, eslintを利用しています

```
$ rubocop -a
```

## 企画資料

企画にあたり、エレベーターピッチ、ペーパープロトタイプの作成を行いました。
下記リンクにて、掲載しております。

[企画資料一覧](./doc/README.md)
