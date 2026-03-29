# RULES_DETAIL.md（プロジェクト固有ルール / Detail）

## docs 契約
- `docs/RESEARCH.yaml`:
  `purpose / facts / unresolved / design_handoff`
- `docs/DESIGN.md`:
  `管理情報 / 目的 / 要求事項 / 制約 / 実装対象 / 非対象 / 変更対象ファイル / 実装手順 / テスト観点 / リスク / codexへの実装指示`
- `docs/PATCH.yaml`:
  `design_id / result / reason / summary / changed_files / verify_request`
- `docs/VERIFY.md`:
  `管理情報 / 検証対象 / 検証結果 / PASS / FAIL 判定 / 発見した問題 / 原因推定 / 戻し先 / 修正提案 / 再検証条件`

## FAIL 分類
| 分類 | 典型例 | 戻し先 |
| --- | --- | --- |
| design | 調査不足、設計矛盾、静的検証失敗 | Claude または Gemini |
| implementation | 実装ミス、仕様未反映 | Codex |
| environment | 権限不足、外部サービス、環境検証失敗 | Codex または Human |
| device | 実機依存、導入先依存 | Codex または Human |
| approval | 承認待ち、判断待ち | Human |

## 再実行ルール
- `design` は調査または設計補強完了まで次フェーズへ進めない。
- `environment` は原因切り分けが終わるまで本番判断へ進めない。
- `approval` は明示承認があるまで停止する。
