# CHaserLua Documentation

> [!NOTE]
> 旧バージョンのCHaserLuaは[こちら](https://github.com/kqnade/CHaserLua-archive)です。

> [!IMPORTANT]
> 現在、開発中であり正常動作は保証されていません。
> 安定版リリースを待つか、本コードを改変してご利用ください。

## 目次

- [CHaser Luaとは](#chaser-luaとは)
- [利用方法](#利用方法)
  - [CHaserLuaのダウンロード](#chaserluaのダウンロード)
  - [CHaserLuaの実行](#chaserluaの実行)
- [技術仕様](#技術仕様)
  - [CHaserLuaの設計仕様](#chaserluaの基本仕様)
  - [CHaserLuaの基本メソッド](#chaserluaの基本メソッド)
  - [CHaserLuaの基本定数](#chaserluaの基本定数)
- [CHaserLuaのサンプルプログラム](#chaserluaのサンプルプログラム)
  - [サンプルプログラムの実行](#サンプルプログラムの実行)
- [CHaserLuaの開発](#chaserluaの開発)
  - [CHaserLuaの開発環境](#chaserluaの開発環境)
  - [CHaserLuaの開発方法](#chaserluaの開発方法)
- [CHaserLuaのライセンス](#chaserluaのライセンス)

## CHaserLuaとは

CHaserLuaは、CHaser[^1]のLua用ライブラリです。CHaserLuaを利用することで、CHaserのエージェントコードをLuaで記述することができます。

[^1]: CHaserの詳細については、[こちら](http://www.zenjouken.com/?action=common_download_main&upload_id=489)を参照してください。

## 利用方法

### CHaserLuaのダウンロード

CHaserLuaは、GitHubのリポジトリの[Releases](https:..github.com/kqnade/CHaserLua/releases)からダウンロードすることができます。  
Releaseページより `connect.lua`をダウンロードしてください。
テストエージェントが必要な場合は`testClient.lua`をダウンロードしてください。

### CHaserLuaの実行

CHaserLuaを実行するには、Luaの実行環境、`luarocks`、`luajit`、`connect.lua`、エージェントコードを記述したLuaファイルが必要です。

`connect.lua`をプロジェクトディレクトリに配置し、エージェントコードを記述したLuaファイルの中で`connect.lua`を読み込んでください。

```lua
require("connect")
```

エージェントコードを記述したLuaファイルを実行することで、CHaserLuaが起動します。

```bash
$ lua agent.lua
```

## 技術仕様

### CHaserLuaの設計仕様

CHaserLuaは、CHaserの仕様に準拠して設計されています。CHaserLuaは、以下の基本メソッドと基本定数を提供しています。

### CHaserLuaの基本メソッド

CHaserLuaは、以下の基本メソッドを提供しています。

- `getReady()`
  - 自分の周囲3x3のマスの情報を取得します。
  - 引数: なし
  - 戻り値: マスの情報 Array(9)
- `walk(direction)`
  - 指定した方向に移動します。
  - 引数: `Up`, `Down`, `Left`, `Right`
  - 戻り値: なし (Void)
- `look(direction)`
  - 指定した方向の3x3のマスの情報を取得します。
  - 引数: `Up`, `Down`, `Left`, `Right`
  - 戻り値: マスの情報 Array(9)
- `search(direction)`
  - 指定した方向の直線9マスの情報を取得します。
  - 引数: `Up`, `Down`, `Left`, `Right`
  - 戻り値: マスの情報 Array(9)
- `put(direction)`
  - 指定した方向にブロックを置きます。
  - 引数: `Up`, `Down`, `Left`, `Right`
  - 戻り値: なし (Void)

### CHaserLuaの機能

CHaserLuaは、以下のメソッドを効率化のために提供しています。

- AbleToMove(direction)
  - エージェントが移動可能かどうかを判定します。
  - 引数: `Up`, `Down`, `Left`, `Right`
  - 戻り値: 移動可能な場合は`true`、移動不可能な場合は`false`
- LastMove()
  - エージェントの最後の移動方向を取得します。
  - 引数: なし
  - 戻り値: 最後の移動方向 `Up`, `Down`, `Left`, `Right`
- RandomMove()
  - ランダムな方向に移動します。(移動可能方向のみ)
  - 引数: なし
  - 戻り値: なし (Void)

## CHaserLuaのサンプルプログラム

CHaserLuaのサンプルプログラムは、GitHubのリポジトリの[Samples](https://github.com/kqnade/CHaserLua/samples)または、[Releases](https://github.com/kqnade/CHaserLua/releases)の`testClient.lua`が利用できます。

### サンプルプログラムの実行

サンプルプログラムを実行するには、以下のコマンドを実行してください。

```bash
$ lua [sampleFile.lua]
```

## CHaserLuaの開発

### CHaserLuaの開発環境

- Lua 5.4 (Latest)
- LuaJIT 2.1
- LuaRocks 3.11

CHaserLuaの主要メンバーの開発環境は、以下の通りです。

- [kqnade](https://github.com/kqnade)
  - OS: Ubuntu 22.04 LTS in WSL2
  - Editor: Neovim, Visual Studio Code

### CHaserLuaの開発方法

CHaserLuaの開発方法は、以下の通りです。

1. リポジトリをフォークする。
2. ブランチを切る。
3. コードを修正する。
4. テストを実行する。
5. コードをコミットする。
6. プルリクエストを作成する。

### CHaserLuaのライセンス

CHaserLuaは、MITライセンスのもとで公開されています。詳細については、[LICENSE](https://github.com/kqnade/CHaserLua/LICENSE)を参照してください。
