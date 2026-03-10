# ACCESS_POLICY.md

## 目的
- AIエージェントごとの参照可能範囲と承認境界を固定する。
- 実値の秘密情報は `SECRETS_LOCAL.md` または `.env` にのみ保持し、本ファイルには記載しない。

## AIごとの参照範囲

### Gemini
- 参照可: `PROJECT.md`, `RULES.md`, `state_compact.json`, `work_journal.md`, `docs/` 配下
- 参照不可: パスワード、APIキー、秘密鍵などの実値
- 備考: 調査・要件整理専用

### Claude（計画・設計）
- 参照可: `docs/RESEARCH.yaml`, `PROJECT.md`, `RULES.md`, `state_compact.json`
- 参照不可: パスワード、APIキー、秘密鍵などの実値
- 備考: `docs/DESIGN.md` の作成専用。実装コードの直接編集は行わない

### Codex
- 参照可: `docs/DESIGN.md`, 実装対象コード, `state_compact.json`, `artifacts/summary.txt`, `artifacts/errors.txt`
- 参照不可: パスワード、APIキー、秘密鍵などの実値
- 備考: 必要な環境変数名のみ参照可。実値参照は不可

### Claude Code（実装検証）
- 参照可: `docs/DESIGN.md`, `docs/PATCH.yaml`, テスト結果, `state_compact.json`, `artifacts/summary.txt`, `artifacts/errors.txt`
- 参照不可: パスワード、APIキー、秘密鍵などの実値
- 備考: 検証・戻し先判断専用。仕様変更や本実装の追加は原則行わない

### Human
- 参照可: すべて
- 備考: 実値管理者・最終承認者

## 承認が必要な操作
- 本番反映
- 削除・上書き
- 認証情報の利用
- 外部公開設定変更
- 横断影響を持つ環境変更
