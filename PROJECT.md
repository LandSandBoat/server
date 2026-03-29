# PROJECT.md（作業開始の入口）

## このファイルの役割
- このファイルは、このプロジェクトで最初に読む入口である。
- 共通ルールは [AGENTS.md](/D:/program/workspace-meta/AGENTS.md) と [SESSION_CORE.md](/D:/program/workspace-meta/SESSION_CORE.md) を参照する。
- ここでは案件固有の目的、現在フェーズ、読む順序、注意点だけを保持する。

## 最初に読む順序
1. [SESSION_CORE.md](/D:/program/workspace-meta/SESSION_CORE.md)
2. [AGENTS.md](/D:/program/workspace-meta/AGENTS.md)
3. `state_compact.json`
4. 必要なら `RULES.md`
5. 横断影響がある、またはその可能性がある場合のみ [GLOBAL_ACTIVE.md](/D:/program/workspace-meta/GLOBAL_ACTIVE.md)
6. 直近の経緯が必要な場合のみ `work_journal.md` の末尾

## 必要時だけ読むもの
- 長い共通運用の詳細:
  [AGENTS_DETAIL.md](/D:/program/workspace-meta/AGENTS_DETAIL.md)
- 横断変更の履歴:
  [GLOBAL_CHANGES.md](/D:/program/workspace-meta/GLOBAL_CHANGES.md)
- docs 詳細ルールやフェーズ別詳細:
  `RULES_DETAIL.md`
- 調査成果物:
  `docs/RESEARCH.yaml`
- 設計成果物:
  `docs/DESIGN.md`
- 実装成果物:
  `docs/PATCH.yaml`
- 検証成果物:
  `docs/VERIFY.md`

## このプロジェクトの概要
- 目的：FFXI エミュレートサーバーの構築、ソースコード (C++) の修正、およびデータベース (SQL) の管理。
- 成果物（期待する完成形）：安定稼働するプライベートサーバー環境および、カスタマイズされたゲームコンテンツ。
- 主な技術要素（言語 / ライブラリ / ツール）：C++, Lua, SQL (MariaDB), Docker, CMake, ZeroMQ。

---

## 現在の作業フェーズ

> **フェーズは固定して運用する。フェーズを跨ぐ作業は行わない。**

- [ ] 🔍 調査フェーズ　→ 目的：情報収集と現状把握のみ
- [ ] 🔨 実装フェーズ　→ 目的：コードの作成・変更のみ
- [ ] 🔧 修正フェーズ　→ 目的：バグ修正・設定修正のみ
- [ ] 🧪 検証フェーズ　→ 目的：テスト・動作確認のみ
- [ ] 🚀 運用フェーズ　→ 目的：本番稼働・監視のみ

## この案件で絶対に外せないこと
- 秘密情報の実値を `PROJECT.md` や `docs/*.md` に書かない。
- 本番反映、削除、上書き、認証情報利用、外部公開設定変更は必ずユーザー承認を得る。
- `state_compact.json` を現在状態の主軸とする。

## この案件特有の注意
- （例）本番環境に影響する操作は事前確認必須
- （例）削除・上書き禁止のディレクトリがある

---

## 入口チェック
- [ ] `state_compact.json` が存在する
- [ ] 必要なら `RULES.md` を読んだ
- [ ] 横断影響の有無を判定した
- [ ] フェーズを固定した
