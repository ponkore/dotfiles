# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

[homesick](https://github.com/technicalpickles/homesick) で管理している個人用 dotfiles リポジトリ。全ファイルは `home/` 以下に置かれ、homesick によって `~/` にシンボリックリンクされる。

## Homesick コマンド

```bash
homesick link dotfiles    # home/ から ~/ へシンボリックリンクを作成（再作成）
homesick pull dotfiles    # 最新変更を取得してリンクを更新
```

## ファイル構成

`home/` 以下がホームディレクトリの構造をそのまま反映している：

- `home/.zshenv` — `ZDOTDIR=$HOME/.config/zsh` を設定し `$ZDOTDIR/.zshenv` を読み込む
- `home/.config/zsh/.zshrc` — zsh のメイン設定（環境変数、PATH、各ツール初期化、エイリアス）
- `home/.config/zsh/.zimrc` — Zim プラグインマネージャのモジュール定義
- `home/.config/zsh/abbreviations` — zsh-abbr の略語定義（入力時にインライン展開される）
- `home/.config/wezterm/wezterm.lua` — WezTerm ターミナルエミュレータ設定
- `home/.config/clojure/deps.edn` — Clojure CLI グローバル依存関係設定
- `home/.gitconfig` — Git ユーザー・エイリアス・ツール設定
- `home/.vimrc` — Vim 設定
- `home/.tmux.conf` — tmux 設定（プレフィックスキー: `C-t`）
- `home/.bashrc` / `home/.bash_profile` — Bash 設定（zsh より更新頻度は低め）

## Zsh アーキテクチャ

[Zim](https://zimfw.sh/) をプラグインマネージャとして使用：

- Zim ホーム: `~/.config/zsh/.zim/`
- `.zimrc` で宣言したモジュールは `.zim/modules/` にインストールされる
- 主なモジュール: `eriner`（プロンプト）、`zsh-abbr`、`fzf`、`zsh-autosuggestions`、`zsh-syntax-highlighting`、`zsh-history-substring-search`

Zim モジュールの更新：
```bash
zimfw update
zimfw upgrade
```

## 略語（zsh-abbr）

`home/.config/zsh/abbreviations` の略語はエイリアスと異なり、入力時にインライン展開される。主なもの：

| 略語 | 展開後 |
|------|--------|
| `g`  | `git` |
| `s`  | `git status -sb` |
| `di` | `git diff` |
| `gl` / `l` | `git log` |
| `d`  | `docker` |
| `dc` | `docker compose` |

## バージョン管理ツール

`.zshrc` は各ディレクトリが存在する場合のみ初期化する：

- **Node.js**: nvm（`~/.nvm` または Homebrew の nvm）
- **Python**: pyenv（`~/.pyenv`）
- **Ruby**: rbenv（`~/.rbenv`）
- **Go**: `~/.go` を GOPATH として使用
- **Rust**: `~/.cargo/env`

## プラットフォーム

- メイン環境: macOS（Apple Silicon、`/opt/homebrew`）
- `.bashrc` には過去の Windows/MSYS/FreeBSD 向け条件分岐が残っている
- WezTerm はフォント HackGen Console NF、日本語 IME 対応（`use_ime = true`）で設定済み
