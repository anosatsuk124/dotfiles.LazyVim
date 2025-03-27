# CodeCompanionSave Command

## 保存先ディレクトリ
- パス: `$NVIM_DATA_DIR/cc_saves/`
  - Linux/macOS: `~/.local/share/nvim/cc_saves/`
  - Windows: `~/AppData/Local/nvim-data/cc_saves/`
- ディレクトリは初回実行時に自動生成

## ファイル名規則
- デフォルト: `YYYY-MM-DD-HH-MM-SS.md` (実行時の日時)
- 引数指定: `:CodeCompanionSave custom-name` → `custom-name.md`

## 機能概要
1. 現在のCodeCompanionチャットバッファの内容を保存
2. Markdown形式(`.md`)で保存
3. 保存ファイルは`CodeCompanionLoad`で一覧/選択可能

## 関連コマンド
- `:CodeCompanionLoad`: 保存済みチャットの一覧表示/読み込み
- 削除機能: ファイルピッカー内で`dd`キーで削除可能

## 実装ファイル
- `lua/user-utils/codecomponion-cmds.lua`
