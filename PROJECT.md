# PROJECT.md（作業開始の唯一の入口）

## ⛔ 作業開始前の絶対必須読み込み（これを読まずに作業してはいけない）

> **AIエージェントへの強制指示：** このファイルを開いた場合、以下を最初の行動として実行すること。他の作業・回答・判断はすべて後回しにする。

```
Step 1: D:\program\workspace-meta\AGENTS.md を全文読み込む（省略禁止）
Step 2: D:\program\workspace-meta\GLOBAL_CHANGES.md を全文読み込む（省略禁止）
Step 3: 上記2ファイルを読んだことを明示してから、以下の作業順序に進む
```

---

## このファイルの役割（必読）
- **このファイルがプロジェクトの唯一の入口**である。
- AIエージェントは作業開始前に必ずこの順で参照すること。
- コンテキスト最小化原則：**必要なファイルだけを読む**。すべてを再送信しない。

---

## 共通ルール（meta）の場所
- `D:\program\workspace-meta\AGENTS.md`（共通憲法）
- `D:\program\workspace-meta\GLOBAL_CHANGES.md`（横断影響ログ）

---

## 作業前に参照する順序（最重要・この順を守る）

| 順 | ファイル（フルパス） | 読む目的 | 読み方 | 必須 |
|----|---------------------|----------|--------|------|
| 1 | `D:\program\workspace-meta\AGENTS.md` | **共通ルール・憲法の確認** | **全文（省略禁止）** | ⛔ 必須 |
| 2 | `D:\program\workspace-meta\GLOBAL_CHANGES.md` | 横断影響の確認 | **全文（省略禁止）** | ⛔ 必須 |
| 3 | `RULES.md` | プロジェクト固有ルールの確認 | 全文 | 必須 |
| 4 | `state_compact.json` | **現在の作業ステートの確認（最重要）** | 全文 | 必須 |
| 5 | `work_journal.md` | 直近ログの確認 | 末尾のみ | 推奨 |

> **注意：** `AGENTS.md` の規定により、作業状態の主軸は `state_compact.json` となる。
> `state_compact.json` が存在しない場合のみ、`work_journal.md` やその他のステートファイルを参照すること。

---

## AI情報最小化ルール（最重要）

- **コンテキスト再送信禁止：** 一度読んだ内容は再送しない。変更点のみ伝える。
- **渡すログは summary/errors のみ：** 生ログ・フルログはAIに渡さない。
- **`state_compact.json` を状態の主軸とする：** （AGENTS.md準拠）他ファイルはその補足に過ぎない。
- **推論禁止・確認手順：** 分からない部分・見えない部分は推論せず、必ずユーザーに問い合わせること。（AGENTS.md準拠）
  **各エージェントAI（Codex/Claude等）は、原則としてオーケストレーターであるGeminiを経由してユーザーへ確認を求めること。**

---

## このプロジェクトの概要
- 目的：FFXI エミュレートサーバーの構築、ソースコード (C++) の修正、およびデータベース (SQL) の管理。
- 成果物（期待する完成形）：安定稼働するプライベートサーバー環境および、カスタマイズされたゲームコンテンツ。
- 主な技術要素（言語 / ライブラリ / ツール）：C++, Lua, SQL (MariaDB), Docker, CMake, ZeroMQ。

---

## 推奨フォルダ構成（必要に応じて編集）
- ルート固定（運用・状態管理）
  - `PROJECT.md`
  - `RULES.md`
  - `state_compact.json`
  - `work_journal.md`
  - `current_status.md`
  - `CHANGELOG_LOCAL.md`
- `docs/`（調査・設計・実装・検証・手順）
  - `docs/RESEARCH.yaml`（AI間受け渡し専用・YAML）
  - `docs/DESIGN.md`（人間レビュー対象・Markdown）
  - `docs/PATCH.yaml`（AI間受け渡し専用・YAML）
  - `docs/VERIFY.md`（人間レビュー対象・Markdown）
- セキュリティ・権限制御
  - `ACCESS_POLICY.md`
  - `SECRETS_LOCAL.md`（Git管理しない。実値はここまたは `.env` のみ）
- `scripts/`（実行ファイル）
  - `scripts/` 配下に `*.ps1` / `*.bat` / `*.sh`
- `artifacts/`（実行結果）
  - `artifacts/summary.txt`
  - `artifacts/errors.txt`

---

## 手動コピー後の初期化手順
- `_templates` 一式を手動で新規プロジェクトディレクトリへコピーする。
- コピー先のプロジェクトルートで `python create_project.py --project-root .` を実行すると、`state_compact.json` / `current_status.md` / `work_journal.md` / `CHANGELOG_LOCAL.md` を初期化できる。
- Windows では、コピー先の `initialize_project.bat` をダブルクリックしても同じ初期化を実行できる。
- `AGENTS.md` や `GLOBAL_CHANGES.md` のシンボリックリンクを張るには、コピー先の `create_symlink.bat` を**管理者権限**で実行する。
- 別ディレクトリを対象にする場合は `python <workspace-meta>\\create_project.py --project-root <対象プロジェクトルート>` を使う。
- `create_project.py` はコピー処理を行わず、既に存在するプロジェクトルートだけを初期化する。
- 初期化直後は必ず `PROJECT.md` の概要欄、`RULES.md` の固有ルール、`docs/RESEARCH.yaml` と `docs/DESIGN.md` の内容を案件に合わせて更新する。

---

## 現在の作業フェーズ（どれか1つに ✅）

> **フェーズは固定して運用する。フェーズを跨ぐ作業は行わない。**

- [ ] 🔍 調査フェーズ　→ 目的：情報収集と現状把握のみ
- [ ] 🔨 実装フェーズ　→ 目的：コードの作成・変更のみ
- [ ] 🔧 修正フェーズ　→ 目的：バグ修正・設定修正のみ
- [ ] 🧪 検証フェーズ　→ 目的：テスト・動作確認のみ
- [ ] 🚀 運用フェーズ　→ 目的：本番稼働・監視のみ


## docs 契約ファイル（固定）
- `docs/RESEARCH.yaml` は **purpose / facts / unresolved / design_handoff** キーを必須とする（YAML形式・AI間受け渡し専用）。
- `docs/DESIGN.md` は **管理情報 / 目的 / 要求事項 / 制約 / 実装対象 / 非対象 / 変更対象ファイル / 実装手順 / テスト観点 / リスク / codexへの実装指示** を必須とする。
- `docs/PATCH.yaml` は **design_id / result / reason / summary / changed_files / verify_request** キーを必須とする（YAML形式・AI間受け渡し専用）。
- `docs/VERIFY.md` は **管理情報 / 検証対象 / 検証結果 / PASS / FAIL 判定 / 発見した問題 / 原因推定 / 戻し先 / 修正提案 / 再検証条件** を必須とする。
- AIエージェントは、各ファイルの章立て・キーを削除せず、未確定項目は「未確定」と明記する。

## テンプレート複製直後の初期化ルール
- `docs/RESEARCH.yaml` / `docs/DESIGN.md` / `docs/PATCH.yaml` / `docs/VERIFY.md` の雛形は、**存在していても成果物完成扱いにしない**。
- コピー直後は `state_compact.json` の承認フラグと履歴をプロジェクト実態に合わせて初期化する。
- `logs/` や一時生成物、検証用ファイルは新規プロジェクトへ持ち込まない。
- 初回実行では `python orchestrator.py --dry-run` を推奨し、表示コマンド・参照パス・承認状態を確認する。
- `orchestrator.py` を使う場合は、旧フロー前提との差異を確認したうえで利用する。

## 秘密情報・承認境界（最重要）
- 実パスワード、秘密鍵、APIキーなどの実値を `PROJECT.md` や `docs/*.md` に記載してはいけない。
- 実値は `SECRETS_LOCAL.md` または `.env` で管理し、Gitへ追加しない。
- 参照権限は `ACCESS_POLICY.md` に従う。
- 本番反映、削除、上書き、認証情報の利用、外部公開設定変更は、必ずユーザー承認を得てから行う。

---

## 重要な注意事項（このプロジェクト特有のみ記載）
- （例）本番環境に影響する操作は事前確認必須
- （例）削除・上書き禁止のディレクトリがある

---

## 入口チェックリスト（作業開始前に必ず確認）
- [ ] ⛔ `D:\program\workspace-meta\AGENTS.md` を全文読んだか（**最優先・省略禁止**）
- [ ] ⛔ `D:\program\workspace-meta\GLOBAL_CHANGES.md` を全文読んだか（**省略禁止**）
- [ ] 現在いるディレクトリがプロジェクトルートか（`RULES.md` が存在するか）
- [ ] `state_compact.json` が存在するか（あればそれを主軸にする）
- [ ] 今回の作業フェーズは何か（上記から1つ選択・固定）
- [ ] 横断影響（FW/DNS/共有資源）が今回含まれるか
- [ ] `D:\program\workspace-meta\AGENTS.md` のコミット規約を今回作業に照らして確認したか
- [ ] テンプレート複製直後なら `logs/` と一時生成物を除外したか
- [ ] `docs/DESIGN.md` が雛形のままでないことを確認したか
- [ ] 初回なら `--dry-run` でコマンドと参照先を確認したか

---

## 設計フェーズ終了チェック（漏れ防止）
- [ ] `docs/RESEARCH.yaml` を作成または更新したか
- [ ] `docs/DESIGN.md` を作成またはマージ更新したか
- [ ] ユーザー承認（設計レビュー）を得ているか
- [ ] `state_compact.json` / `work_journal.md` を最新化したか

## 実装フェーズ終了チェック（漏れ防止）
- [ ] `docs/PATCH.yaml` を作成または更新したか
- [ ] 各コードに日本語コメントを詳しく付与したか
- [ ] `state_compact.json` / `work_journal.md` を最新化したか

## 検証フェーズ終了チェック（漏れ防止）
- [ ] `docs/VERIFY.md`（またはウォークスルー）を作成・更新したか
- [ ] テスト結果（スクショ・ログ等）を記録したか
- [ ] `state_compact.json` / `work_journal.md` を最新化したか

---

## コミット前確認（確認漏れ防止）
- `D:\program\workspace-meta\AGENTS.md` のコミット規約を再確認すること。
- コミットコメントは日本語・変更内容/変更理由/影響範囲を含めること。
- `state_compact.json` / `work_journal.md` / `CHANGELOG_LOCAL.md` の更新漏れがないか確認すること。
- [ ] `work_journal.md` 末尾へ今回作業を追記したか
- [ ] `git status` で作業対象と不要差分を確認したか
