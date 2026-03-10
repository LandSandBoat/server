#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
orchestrator.py

DESIGN.md / PATCH.yaml / VERIFY.md を使った
半自動マルチAIワークフロー用オーケストレーター

想定フロー（手動ステップ）:
1. Gemini で docs/RESEARCH.yaml を作成（手動）
2. Claude で docs/DESIGN.md を作成（手動）
3. Human が設計承認フラグをONにする（手動）

想定フロー（自動ステップ）:
4. 本スクリプトを実行
5. Codex CLI を呼び出して docs/PATCH.yaml を生成
6. Claude CLI を呼び出して docs/VERIFY.md を生成
7. state_compact.json を更新

特徴:
- CLIの具体的な引数は state_compact.json 側で定義
- スクリプト本体は固定し、CLI仕様変更に強くする
- 状態遷移・ログ保存・エラー時の戻し先記録に対応
- 危険な自動実行を避けるため、設計承認が無い限り先へ進まない
"""

from __future__ import annotations

import argparse
import datetime as dt
import json
import re
import shlex
import shutil
import subprocess
import sys
import traceback
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple


# =========================
# 基本ユーティリティ
# =========================

def now_iso() -> str:
    """現在時刻をISO8601文字列で返す。"""
    return dt.datetime.now().astimezone().isoformat(timespec="seconds")


def ensure_dir(path: Path) -> None:
    """ディレクトリが無ければ作成する。"""
    path.mkdir(parents=True, exist_ok=True)


def read_text(path: Path, encoding: str = "utf-8") -> str:
    """テキストファイル読み込み。"""
    return path.read_text(encoding=encoding)


def write_text(path: Path, content: str, encoding: str = "utf-8") -> None:
    """テキストファイル書き込み。"""
    ensure_dir(path.parent)
    path.write_text(content, encoding=encoding)


def read_json(path: Path) -> Dict[str, Any]:
    """JSON読み込み。"""
    with path.open("r", encoding="utf-8") as f:
        return json.load(f)


def write_json_atomic(path: Path, data: Dict[str, Any]) -> None:
    """
    JSONを一時ファイル経由で安全に書き込む。
    途中で停止しても壊れにくくする。
    """
    ensure_dir(path.parent)
    tmp_path = path.with_suffix(path.suffix + ".tmp")
    with tmp_path.open("w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    tmp_path.replace(path)


def file_exists_and_not_empty(path: Path) -> bool:
    """ファイルが存在し、かつ空でないか判定。"""
    return path.exists() and path.is_file() and path.stat().st_size > 0


def normalize_text(text: str) -> str:
    """比較用に改行と行末空白を正規化する。"""
    return "\n".join(line.rstrip() for line in text.replace("\r\n", "\n").strip().split("\n"))


# コピー直後の雛形を既存成果物と誤認しないため、テンプレート本文を固定で持つ。
DEFAULT_ARTIFACT_TEMPLATES: Dict[str, str] = {
    "design": normalize_text(
        """# DESIGN.md

## 0. 管理情報
- 設計ID:
- ステータス: draft / approved / superseded
- 承認者:
- 実装開始条件:

## 1. 目的
-

## 2. 要求事項
-

## 3. 制約
-

## 4. 実装対象
-

## 5. 非対象
-

## 6. 変更対象ファイル
-

## 7. 実装手順
1.

## 8. テスト観点
-

## 9. リスク
-

## 10. codexへの実装指示
- 本章は必須。未確定なら「未確定」と明記する。"""
    ),
    "patch": normalize_text(
        """# Codex が作成。Claude Code が読む。AI間受け渡し専用（人間レビュー不要）。
design_id: ""
result: success  # success | partial | blocked
reason: none  # none | spec_gap | env_blocker | approval_wait | other
summary: ""
changed_files:
  - ""
changes:
  - ""
steps:
  - ""
impact: ""
unresolved: []
verify_request: \"\""""
    ),
    "verify": normalize_text(
        """# VERIFY.md

## 0. 管理情報
- 対象設計ID:
- 対象実装ID:
- 判定コード: PASS / FAIL / UNKNOWN
- 失敗分類: design / implementation / environment / approval / unknown / none
- 戻し先コード: Gemini / Codex / Claude / Human / None

## 1. 検証対象
-

## 2. 検証結果
-

## 3. PASS / FAIL 判定
- PASS / FAIL / UNKNOWN

## 4. 発見した問題
-

## 5. 原因推定
-

## 6. 戻し先
- Gemini / Codex / Claude / Human / None

## 7. 修正提案
-

## 8. 再検証条件
-"""
    ),
}

REQUIRED_SECTIONS: Dict[str, List[str]] = {
    "design": [
        "0. 管理情報",
        "1. 目的",
        "2. 要求事項",
        "3. 制約",
        "4. 実装対象",
        "5. 非対象",
        "6. 変更対象ファイル",
        "7. 実装手順",
        "8. テスト観点",
        "9. リスク",
        "10. codexへの実装指示",
    ],
    # patch は YAML形式のため REQUIRED_YAML_KEYS で検証する
    "verify": [
        "0. 管理情報",
        "1. 検証対象",
        "2. 検証結果",
        "3. PASS / FAIL 判定",
        "4. 発見した問題",
        "5. 原因推定",
        "6. 戻し先",
        "7. 修正提案",
        "8. 再検証条件",
    ],
}

REQUIRED_YAML_KEYS: Dict[str, List[str]] = {
    "patch": ["design_id", "result", "reason", "summary", "changed_files", "verify_request"],
}

FAILURE_TO_FALLBACK: Dict[str, str] = {
    "design": "Gemini",
    "implementation": "Codex",
    "environment": "Human",
    "approval": "Human",
    "unknown": "Human",
    "none": "",
}


def is_placeholder_artifact(path: Path, key: str) -> bool:
    """テンプレート配布直後の雛形そのものかを判定する。"""
    if not file_exists_and_not_empty(path):
        return False
    default_text = DEFAULT_ARTIFACT_TEMPLATES.get(key)
    if default_text is None:
        return False
    return normalize_text(read_text(path)) == default_text


def artifact_is_ready(path: Path, key: str) -> bool:
    """成果物が存在し、かつ雛形のままでない場合に True を返す。"""
    return file_exists_and_not_empty(path) and not is_placeholder_artifact(path, key)


def artifact_has_required_yaml_keys(path: Path, key: str) -> bool:
    """YAML成果物が必須キーを含むかを判定する。"""
    if not file_exists_and_not_empty(path):
        return False
    required_keys = REQUIRED_YAML_KEYS.get(key, [])
    if not required_keys:
        return True
    text = read_text(path).replace("\r\n", "\n")
    for k in required_keys:
        if not re.search(rf"(?m)^{re.escape(k)}\s*:", text):
            return False
    return True


def artifact_has_required_sections(path: Path, key: str) -> bool:
    """成果物が契約上の必須章を満たしているかを判定する。"""
    if not file_exists_and_not_empty(path):
        return False

    required_sections = REQUIRED_SECTIONS.get(key, [])
    if not required_sections:
        return True

    text = read_text(path).replace("\r\n", "\n")
    for heading in required_sections:
        if not re.search(rf"(?m)^##\s+{re.escape(heading)}\s*$", text):
            return False
    return True


def extract_section_body(text: str, heading: str) -> str:
    """指定見出しの本文だけを抜き出す。"""
    normalized = text.replace("\r\n", "\n")
    pattern = rf"(?ms)^##\s+{re.escape(heading)}\s*\n(.*?)(?=^##\s+|\Z)"
    match = re.search(pattern, normalized)
    if not match:
        return ""
    return match.group(1).strip()


def extract_bullet_value(text: str, heading: str, label: str) -> str:
    """見出し内の `- ラベル: 値` を抽出する。"""
    body = extract_section_body(text, heading)
    for line in body.splitlines():
        stripped = line.strip()
        prefix = f"- {label}:"
        if stripped.startswith(prefix):
            return stripped[len(prefix):].strip()
    return ""


def extract_label_value_fallback(text: str, label: str) -> str:
    """見出し構造が無い文書向けに、単純な `ラベル: 値` を拾う。"""
    pattern = rf"(?mi)^[>\-\*\s]*{re.escape(label)}\s*:\s*(.+?)\s*$"
    match = re.search(pattern, text)
    if not match:
        return ""
    return match.group(1).strip()


def design_is_approved(design_text: str) -> bool:
    """
    DESIGN.md から承認済みかを判定する。
    現行テンプレートの「0. 管理情報」を優先し、旧形式の単純記法も補助的に見る。
    """
    status = extract_bullet_value(design_text, "0. 管理情報", "ステータス")
    approver = extract_bullet_value(design_text, "0. 管理情報", "承認者")

    if not status:
        status = extract_label_value_fallback(design_text, "ステータス")
    if not approver:
        approver = extract_label_value_fallback(design_text, "承認者")

    normalized_status = status.lower()
    if "approved" in normalized_status:
        return True

    normalized_approver = approver.strip().lower()
    if normalized_approver and normalized_approver not in {"", "-", "未定", "none", "n/a"}:
        return True

    return False


# =========================
# ログ
# =========================

class Logger:
    """簡易ロガー。コンソール表示とファイル追記を行う。"""

    def __init__(self, log_file: Path) -> None:
        self.log_file = log_file
        ensure_dir(log_file.parent)

    def _write(self, level: str, message: str) -> None:
        timestamp = now_iso()
        line = f"[{timestamp}] [{level}] {message}"
        print(line)
        with self.log_file.open("a", encoding="utf-8") as f:
            f.write(line + "\n")

    def info(self, message: str) -> None:
        self._write("INFO", message)

    def warn(self, message: str) -> None:
        self._write("WARN", message)

    def error(self, message: str) -> None:
        self._write("ERROR", message)


# =========================
# state_compact.json 管理
# =========================

class StateManager:
    """
    state_compact.json の読み書きを担当するクラス。
    キーが存在しない場合でも最低限動けるように補完する。
    """

    def __init__(self, state_path: Path, logger: Logger) -> None:
        self.state_path = state_path
        self.logger = logger
        self.data = self._load_and_normalize()

    def _load_and_normalize(self) -> Dict[str, Any]:
        if not self.state_path.exists():
            raise FileNotFoundError(f"state_compact.json が見つかりません: {self.state_path}")

        state = read_json(self.state_path)

        # 必須トップレベルの最低補完
        state.setdefault("ワークフロー状態", {})
        state.setdefault("テンプレート情報", {})
        state.setdefault("実行管理", {})
        state.setdefault("成果物", {})
        state.setdefault("承認", {})
        state.setdefault("automation", {})
        state.setdefault("履歴", [])

        wf = state["ワークフロー状態"]
        wf.setdefault("工程", "design")
        wf.setdefault("状態", "pending")
        wf.setdefault("結果", "pending")
        wf.setdefault("現在ステップ", "design")
        wf.setdefault("次ステップ", "design")
        wf.setdefault("手動確認待ち", False)
        wf.setdefault("再実行可否", False)
        wf.setdefault("失敗分類", "none")
        wf.setdefault("最終判定理由", "")
        wf.setdefault("戻し先", "")
        wf.setdefault("ブロッカー", [])

        template_info = state["テンプレート情報"]
        template_info.setdefault("テンプレート版", "2026-03-07")
        template_info.setdefault("コピー後初期化要否", True)

        run = state["実行管理"]
        run.setdefault("プロジェクトID", self.state_path.parent.name)
        run.setdefault("最新実行ID", "")
        run.setdefault("試行回数", 0)
        run.setdefault("最大試行回数", 3)
        run.setdefault("最終更新者", "Human")

        artifacts = state["成果物"]
        artifacts.setdefault("design", {})
        artifacts.setdefault("patch", {})
        artifacts.setdefault("verify", {})

        artifacts["design"].setdefault("パス", "docs/DESIGN.md")
        artifacts["design"].setdefault("存在", False)
        artifacts["design"].setdefault("最終更新", "")

        artifacts["patch"].setdefault("パス", "docs/PATCH.yaml")
        artifacts["patch"].setdefault("存在", False)
        artifacts["patch"].setdefault("最終更新", "")

        artifacts["verify"].setdefault("パス", "docs/VERIFY.md")
        artifacts["verify"].setdefault("存在", False)
        artifacts["verify"].setdefault("最終更新", "")

        approvals = state["承認"]
        approvals.setdefault("設計承認", False)
        approvals.setdefault("実装承認", False)
        approvals.setdefault("検証確認", False)
        approvals.setdefault("本番反映承認", False)

        automation = state["automation"]
        automation.setdefault("enabled", True)
        automation.setdefault("dry_run", False)
        automation.setdefault("max_step_count", 10)
        automation.setdefault("adapters", {})
        automation["adapters"].setdefault("codex", {})
        automation["adapters"].setdefault("claude", {})

        # 例:
        # state["automation"]["adapters"]["codex"]["command"] = [
        #   "codex", "exec", "--cwd", "{project_root}", "--output-last-message", "{patch_path}", "{codex_prompt}"
        # ]
        # state["automation"]["adapters"]["claude"]["command"] = [
        #   "claude", "-p", "{claude_prompt}"
        # ]

        return state

    def save(self) -> None:
        write_json_atomic(self.state_path, self.data)

    def append_history(self, event: str, detail: Optional[Dict[str, Any]] = None) -> None:
        item = {
            "timestamp": now_iso(),
            "event": event,
            "detail": detail or {}
        }
        self.data.setdefault("履歴", []).append(item)

    def set_workflow(self, *, phase: Optional[str] = None,
                     status: Optional[str] = None,
                     result: Optional[str] = None,
                     current_step: Optional[str] = None,
                     next_step: Optional[str] = None,
                     manual_review_required: Optional[bool] = None,
                     retryable: Optional[bool] = None,
                     failure_category: Optional[str] = None,
                     reason: Optional[str] = None,
                     fallback_to: Optional[str] = None,
                     blockers: Optional[List[str]] = None) -> None:
        wf = self.data["ワークフロー状態"]
        if phase is not None:
            wf["工程"] = phase
        if status is not None:
            wf["状態"] = status
        if result is not None:
            wf["結果"] = result
        if current_step is not None:
            wf["現在ステップ"] = current_step
        if next_step is not None:
            wf["次ステップ"] = next_step
        if manual_review_required is not None:
            wf["手動確認待ち"] = manual_review_required
        if retryable is not None:
            wf["再実行可否"] = retryable
        if failure_category is not None:
            wf["失敗分類"] = failure_category
        if reason is not None:
            wf["最終判定理由"] = reason
        if fallback_to is not None:
            wf["戻し先"] = fallback_to
        if blockers is not None:
            wf["ブロッカー"] = blockers

    def set_artifact_state(self, key: str, *, exists: bool, updated_at: Optional[str] = None) -> None:
        art = self.data["成果物"][key]
        art["存在"] = exists
        art["最終更新"] = updated_at or now_iso()

    def get_artifact_path(self, project_root: Path, key: str) -> Path:
        rel = self.data["成果物"][key]["パス"]
        return project_root / rel

    def approval(self, key: str) -> bool:
        return bool(self.data["承認"].get(key, False))

    def get_adapter_command(self, agent_name: str) -> List[str]:
        cmd = self.data["automation"]["adapters"].get(agent_name, {}).get("command", [])
        if not isinstance(cmd, list):
            raise ValueError(f"{agent_name} の command は list で指定してください。")
        return cmd

    def get_automation_flag(self, key: str, default: Any = None) -> Any:
        return self.data.get("automation", {}).get(key, default)

    def get_run_id(self) -> str:
        return str(self.data.get("実行管理", {}).get("最新実行ID", ""))

    def prepare_run(self) -> str:
        """run_id を採番するが、試行回数はまだ増やさない。"""
        run_id = dt.datetime.now().strftime("run_%Y%m%d_%H%M%S")
        run = self.data["実行管理"]
        run["最新実行ID"] = run_id
        run["最終更新者"] = "orchestrator"
        return run_id

    def increment_try_count(self) -> int:
        """実際に今回の実行を消費するときだけ試行回数を増やす。"""
        run = self.data["実行管理"]
        run["試行回数"] = int(run.get("試行回数", 0)) + 1
        return int(run["試行回数"])

    def mark_updated_by(self, actor: str) -> None:
        self.data.setdefault("実行管理", {})["最終更新者"] = actor


# =========================
# プロンプト生成
# =========================

def build_codex_prompt(project_root: Path, design_path: Path, patch_path: Path, state_path: Path) -> str:
    """
    Codex CLI に渡す実装用プロンプトを生成する。
    PATCH.yaml を成果物として生成/更新させる前提。
    """
    return f"""\
あなたは実装担当エージェントです。
役割は DESIGN.md に従って必要なコードや関連ファイルを実装し、その結果を PATCH.yaml に記録することです。

作業対象:
- プロジェクトルート: {project_root}
- 設計書: {design_path}
- 出力先: {patch_path}
- 状態管理: {state_path}

必須ルール:
1. まず {design_path} を読む
2. 設計意図から外れず、必要な実装を行う
3. 実装に必要なコード、設定、スクリプト、関連ドキュメントは適切に更新してよい
4. PATCH.yaml の契約を守る（YAML形式で出力する）
5. 最低限、PATCH.yaml は必ず更新する
6. 不明点や未確定点は unresolved に明記する
7. 最終的に PATCH.yaml に以下のキーを含める（YAML形式）
   - design_id: 対象設計書ID
   - result: success / partial / blocked
   - reason: none / spec_gap / env_blocker / approval_wait / other
   - summary: 実装概要
   - changed_files: 変更ファイル一覧
   - changes: 変更内容
   - steps: 実行手順
   - impact: 想定される影響範囲
   - unresolved: 未対応事項
   - verify_request: Claude Code への検証依頼（重点確認箇所を明記）

重要:
- 仕様が曖昧で実装不能なら、PATCH.yaml にその理由を書き、無理に進めない
- 設計逸脱を避ける
- 最終応答は PATCH.yaml にそのまま保存される前提で、完成済みの YAML 本文だけを返す
"""


def resolve_command_executable(command: List[str]) -> List[str]:
    """
    実行ファイル名を OS に合わせて補完する。
    Windows では npm 由来 CLI の .cmd を優先する。
    """
    if not command:
        return command

    executable = command[0]
    if Path(executable).suffix or Path(executable).parent != Path():
        return command

    candidates = [executable]
    if sys.platform.startswith("win"):
        candidates = [f"{executable}.cmd", f"{executable}.exe", executable]

    for candidate in candidates:
        resolved = shutil.which(candidate)
        if resolved:
            return [resolved, *command[1:]]

    return command

def build_claude_prompt(project_root: Path, design_path: Path, patch_path: Path, verify_path: Path, state_path: Path) -> str:
    """
    Claude CLI に渡す検証用プロンプトを生成する。
    VERIFY.md を成果物として生成/更新させる前提。
    """
    return f"""\
あなたは検証担当エージェントです。
役割は DESIGN.md と PATCH.yaml（YAML形式の実装報告）と実装済みファイルを検証し、結果を VERIFY.md に記録することです。

作業対象:
- プロジェクトルート: {project_root}
- 設計書: {design_path}
- 実装報告（YAML）: {patch_path}
- 出力先: {verify_path}
- 状態管理: {state_path}

必須ルール:
1. まず {design_path} と {patch_path} を読む（PATCH.yaml は YAML形式）
2. 設計整合性、実装妥当性、未対応事項、リスクを確認する
3. VERIFY.md の契約を守る（Markdown形式で出力する）
4. PASS / FAIL を明示する
5. FAIL の場合は「戻し先」を明記する
   - 設計問題なら Gemini または Claude
   - 実装問題なら Codex
   - 環境/判断待ちなら Human
6. 最終的に VERIFY.md に以下を含める
   - 管理情報（対象設計ID / 対象実装ID / 判定コード / 失敗分類 / 戻し先コード）
   - 検証対象
   - 検証結果
   - PASS / FAIL 判定
   - 発見した問題
   - 原因推定
   - 戻し先
   - 修正提案
   - 再検証条件

重要:
- 実装そのものは原則しない
- 修正は提案に留める
- 不足情報があるなら、VERIFY.md に不足として残す
- 最終応答は VERIFY.md にそのまま保存される前提で、完成済みの Markdown 本文だけを返す
"""


# =========================
# コマンド実行
# =========================

def build_context_map(project_root: Path, state: StateManager) -> Dict[str, str]:
    """テンプレート置換用の値をまとめる。"""
    design_path = state.get_artifact_path(project_root, "design")
    patch_path = state.get_artifact_path(project_root, "patch")
    verify_path = state.get_artifact_path(project_root, "verify")

    context = {
        "project_root": str(project_root),
        "state_path": str(state.state_path),
        "design_path": str(design_path),
        "patch_path": str(patch_path),
        "verify_path": str(verify_path),
        "codex_prompt": build_codex_prompt(project_root, design_path, patch_path, state.state_path),
        "claude_prompt": build_claude_prompt(project_root, design_path, patch_path, verify_path, state.state_path),
    }
    return context


def substitute_placeholders(command_template: List[str], context: Dict[str, str]) -> List[str]:
    """
    コマンドテンプレート内の {name} を置換する。
    例:
    ["codex", "exec", "--cwd", "{project_root}", "{codex_prompt}"]
    """
    rendered: List[str] = []
    for token in command_template:
        try:
            rendered.append(token.format(**context))
        except KeyError as e:
            missing = str(e).strip("'")
            raise KeyError(f"コマンドテンプレート内のプレースホルダが不足しています: {missing}") from e
    return rendered


def normalize_agent_command(command: List[str]) -> List[str]:
    """
    既存 state に残っている古い CLI 引数を現行仕様へ寄せる。
    """
    if not command:
        return command

    normalized = list(command)
    executable_name = Path(normalized[0]).stem.lower()

    if executable_name == "codex":
        normalized = ["-C" if token == "--cwd" else token for token in normalized]

    return normalized


def run_command(command: List[str], cwd: Path, logger: Logger, dry_run: bool) -> Tuple[int, str, str]:
    """
    外部コマンドを実行する。
    dry_run=True の場合は実行せずログだけ出す。
    """
    normalized_command = normalize_agent_command(command)
    resolved_command = resolve_command_executable(normalized_command)
    display = " ".join(shlex.quote(part) for part in resolved_command)
    logger.info(f"実行コマンド: {display}")

    if dry_run:
        logger.warn("dry_run=True のため、実行はスキップしました。")
        return 0, "", ""

    completed = subprocess.run(
        resolved_command,
        cwd=str(cwd),
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace"
    )
    return completed.returncode, completed.stdout, completed.stderr


# =========================
# 判定系
# =========================

def parse_verify_result(verify_text: str) -> Tuple[str, str, str, str]:
    """
    VERIFY.md の管理情報と本文から、判定コード・戻し先・失敗分類・理由を抽出する。
    """
    result = extract_bullet_value(verify_text, "0. 管理情報", "判定コード").upper()
    failure_category = extract_bullet_value(verify_text, "0. 管理情報", "失敗分類").lower()
    fallback_to = extract_bullet_value(verify_text, "0. 管理情報", "戻し先コード")

    if not result:
        result_section = extract_section_body(verify_text, "3. PASS / FAIL 判定").lower()
        if "pass" in result_section and "fail" not in result_section:
            result = "PASS"
        elif "fail" in result_section:
            result = "FAIL"
        else:
            result = "UNKNOWN"

    if not failure_category:
        failure_category = "none" if result == "PASS" else "unknown"

    if not fallback_to:
        fallback_to = FAILURE_TO_FALLBACK.get(failure_category, "Human")

    fallback_section = extract_section_body(verify_text, "6. 戻し先").lower()
    if not fallback_to:
        if "gemini" in fallback_section:
            fallback_to = "Gemini"
        elif "codex" in fallback_section:
            fallback_to = "Codex"
        elif "claude" in fallback_section:
            fallback_to = "Claude"
        elif "human" in fallback_section:
            fallback_to = "Human"

    reason = extract_section_body(verify_text, "2. 検証結果") or extract_section_body(verify_text, "4. 発見した問題")
    return result, fallback_to, failure_category, reason[:200]


def update_artifacts_existence(project_root: Path, state: StateManager) -> None:
    """成果物ファイルの存在フラグを更新する。"""
    for key in ("design", "patch", "verify"):
        path = state.get_artifact_path(project_root, key)
        state.set_artifact_state(key, exists=file_exists_and_not_empty(path), updated_at=now_iso())


def sync_design_approval_from_document(project_root: Path, state: StateManager, logger: Logger) -> bool:
    """
    DESIGN.md 内に承認済み表記があれば state の設計承認へ同期する。
    戻り値は同期後の承認状態。
    """
    design_path = state.get_artifact_path(project_root, "design")
    approved = state.approval("設計承認")

    if approved or not file_exists_and_not_empty(design_path):
        return approved

    try:
        if design_is_approved(read_text(design_path)):
            state.data["承認"]["設計承認"] = True
            state.append_history("design_approval_synced_from_document", {
                "design_path": str(design_path)
            })
            logger.info("DESIGN.md の承認表記を検出したため、state の設計承認を同期しました。")
            return True
    except Exception as exc:
        logger.warn(f"DESIGN.md からの承認同期に失敗しました: {exc}")

    return False


def update_current_status(project_root: Path, state: StateManager) -> None:
    """Human 向けの現在状態サマリーを最小限で更新する。"""
    wf = state.data["ワークフロー状態"]
    run = state.data.get("実行管理", {})
    lines = [
        "# current_status.md（人間向け現状サマリー）",
        "## 常に最新化・上書き専用",
        "",
        "## 1. 目的（このプロジェクトで何をしているか）",
        "- マルチAI開発ワークフローのテンプレートおよび運用状態の管理",
        "",
        "## 2. 前提（頻出の環境情報）",
        "- 稼働環境（ローカル / リモート）：ローカル",
        f"- 稼働ディレクトリ：{project_root}",
        "- 重要設定・運用（外部接続、起動オプション、symlink 等）：state_compact.json を主軸に運用",
        "",
        "## 3. 現在の作業フェーズ",
        f"- フェーズ：{wf.get('工程', '')}",
        f"- フェーズ開始日：{now_iso()[:10]}",
        f"- フェーズ終了条件：次ステップ {wf.get('次ステップ', '')} が完了すること",
        "",
        "## 4. 現在の稼働状態（到達点）",
        f"- 現在の状況：状態={wf.get('状態', '')} / 結果={wf.get('結果', '')} / 戻し先={wf.get('戻し先', '')}",
        f"- 直近の変更で注意すべき点：失敗分類={wf.get('失敗分類', '')} / 手動確認待ち={wf.get('手動確認待ち', False)}",
        "",
        "## 5. 重要な変更点（短縮）",
        f"- {now_iso()[:10]}: run_id={run.get('最新実行ID', '')} / 試行回数={run.get('試行回数', 0)}",
        "",
        "## 6. 未解決 / 要確認（次のアクション）",
        f"- {state.data.get('次のアクション', '')}",
    ]
    write_text(project_root / "current_status.md", "\n".join(lines) + "\n")


# =========================
# メイン処理
# =========================

def do_patch(project_root: Path, state: StateManager, logger: Logger) -> None:
    """Codex CLI で PATCH.md 生成フェーズを実行する。"""
    context = build_context_map(project_root, state)
    patch_path = state.get_artifact_path(project_root, "patch")
    design_path = state.get_artifact_path(project_root, "design")
    dry_run = bool(state.get_automation_flag("dry_run", False))
    run_id = state.get_run_id()

    if not artifact_is_ready(design_path, "design"):
        raise RuntimeError(f"DESIGN.md が未作成、空、または雛形のままです: {design_path}")

    command_template = state.get_adapter_command("codex")
    if not command_template:
        raise RuntimeError("state_compact.json に automation.adapters.codex.command が未設定です。")

    command = substitute_placeholders(command_template, context)

    state.set_workflow(
        phase="patch",
        status="running",
        result="pending",
        current_step="patch",
        next_step="patch",
        manual_review_required=False,
        retryable=False,
        failure_category="none",
        reason="Codex フェーズ実行中",
        fallback_to=""
    )
    state.data["次のアクション"] = "Codex が PATCH.md を生成する"
    state.append_history("patch_started", {"command": command})
    update_current_status(project_root, state)
    state.save()

    returncode, stdout, stderr = run_command(
        command=command,
        cwd=project_root,
        logger=logger,
        dry_run=dry_run,
    )

    log_out = project_root / "logs" / run_id / "codex_stdout.log"
    log_err = project_root / "logs" / run_id / "codex_stderr.log"
    write_text(log_out, stdout or "")
    write_text(log_err, stderr or "")

    if returncode != 0:
        state.set_workflow(
            phase="patch",
            status="failed",
            result="FAIL",
            current_step="patch",
            next_step="patch_retry",
            manual_review_required=False,
            retryable=True,
            failure_category="implementation",
            reason=f"Codex CLI 実行失敗 (returncode={returncode})",
            fallback_to="Codex",
            blockers=[f"Codex CLI failed with returncode={returncode}"]
        )
        state.append_history("patch_failed", {"returncode": returncode})
        state.save()
        raise RuntimeError(f"Codex CLI 実行失敗 (returncode={returncode})")

    if dry_run:
        state.set_workflow(
            phase="patch",
            status="dry_run",
            result="pending",
            current_step="patch",
            next_step="verify",
            manual_review_required=False,
            retryable=True,
            failure_category="none",
            reason="dry-run で PATCH コマンド確認のみ実施",
            fallback_to="Human",
            blockers=["dry_run のため PATCH.md は未生成です"]
        )
        state.append_history("patch_dry_run", {"command": command})
        state.save()
        logger.info("PATCH フェーズの dry-run 完了。")
        return

    update_artifacts_existence(project_root, state)

    if not artifact_is_ready(patch_path, "patch") or not artifact_has_required_yaml_keys(patch_path, "patch"):
        state.set_workflow(
            phase="patch",
            status="failed",
            result="FAIL",
            current_step="patch",
            next_step="patch_retry",
            manual_review_required=False,
            retryable=True,
            failure_category="implementation",
            reason="PATCH.md が見つからないか、雛形のままか、必須章が不足しています",
            fallback_to="Codex",
            blockers=["PATCH.md が生成されていない、雛形のまま、または必須章が不足しています"]
        )
        state.append_history("patch_failed", {"reason": "PATCH.md missing, placeholder, or invalid contract"})
        state.save()
        raise RuntimeError("Codex 実行後の PATCH.md が未生成、雛形、または契約不備です。")

    state.set_workflow(
        phase="patch",
        status="completed",
        result="PASS",
        current_step="patch",
        next_step="verify",
        manual_review_required=False,
        retryable=False,
        failure_category="none",
        reason="PATCH フェーズ完了",
        fallback_to="",
        blockers=[]
    )
    state.append_history("patch_completed", {"patch_path": str(patch_path)})
    state.data["承認"]["実装承認"] = True
    state.save()
    logger.info("PATCH フェーズ完了。")


def do_verify(project_root: Path, state: StateManager, logger: Logger) -> None:
    """Claude CLI で VERIFY.md 生成フェーズを実行する。"""
    context = build_context_map(project_root, state)
    patch_path = state.get_artifact_path(project_root, "patch")
    verify_path = state.get_artifact_path(project_root, "verify")
    design_path = state.get_artifact_path(project_root, "design")
    dry_run = bool(state.get_automation_flag("dry_run", False))
    run_id = state.get_run_id()

    if not artifact_is_ready(design_path, "design"):
        raise RuntimeError(f"DESIGN.md が未作成、空、または雛形のままです: {design_path}")
    if not dry_run and not artifact_is_ready(patch_path, "patch"):
        raise RuntimeError(f"PATCH.md が未作成、空、または雛形のままです: {patch_path}")

    command_template = state.get_adapter_command("claude")
    if not command_template:
        raise RuntimeError("state_compact.json に automation.adapters.claude.command が未設定です。")

    command = substitute_placeholders(command_template, context)

    state.set_workflow(
        phase="verify",
        status="running",
        result="pending",
        current_step="verify",
        next_step="verify",
        manual_review_required=False,
        retryable=False,
        failure_category="none",
        reason="Claude フェーズ実行中",
        fallback_to=""
    )
    state.data["次のアクション"] = "Claude が VERIFY.md を生成する"
    state.append_history("verify_started", {"command": command})
    update_current_status(project_root, state)
    state.save()

    returncode, stdout, stderr = run_command(
        command=command,
        cwd=project_root,
        logger=logger,
        dry_run=dry_run,
    )

    log_out = project_root / "logs" / run_id / "claude_stdout.log"
    log_err = project_root / "logs" / run_id / "claude_stderr.log"
    write_text(log_out, stdout or "")
    write_text(log_err, stderr or "")

    if returncode != 0:
        state.set_workflow(
            phase="verify",
            status="failed",
            result="FAIL",
            current_step="verify",
            next_step="human_review",
            manual_review_required=True,
            retryable=False,
            failure_category="environment",
            reason=f"Claude CLI 実行失敗 (returncode={returncode})",
            fallback_to="Claude",
            blockers=[f"Claude CLI failed with returncode={returncode}"]
        )
        state.append_history("verify_failed", {"returncode": returncode})
        state.save()
        raise RuntimeError(f"Claude CLI 実行失敗 (returncode={returncode})")

    if dry_run:
        state.set_workflow(
            phase="verify",
            status="dry_run",
            result="pending",
            current_step="verify",
            next_step="verify",
            manual_review_required=False,
            retryable=True,
            failure_category="none",
            reason="dry-run で VERIFY コマンド確認のみ実施",
            fallback_to="Human",
            blockers=["dry_run のため VERIFY.md は未生成です"]
        )
        state.append_history("verify_dry_run", {"command": command})
        state.save()
        logger.info("VERIFY フェーズの dry-run 完了。")
        return

    update_artifacts_existence(project_root, state)

    if not artifact_is_ready(verify_path, "verify") or not artifact_has_required_sections(verify_path, "verify"):
        state.set_workflow(
            phase="verify",
            status="failed",
            result="FAIL",
            current_step="verify",
            next_step="verify_retry",
            manual_review_required=False,
            retryable=True,
            failure_category="implementation",
            reason="VERIFY.md が見つからないか、雛形のままか、必須章が不足しています",
            fallback_to="Claude",
            blockers=["VERIFY.md が生成されていない、雛形のまま、または必須章が不足しています"]
        )
        state.append_history("verify_failed", {"reason": "VERIFY.md missing, placeholder, or invalid contract"})
        state.save()
        raise RuntimeError("Claude 実行後の VERIFY.md が未生成、雛形、または契約不備です。")

    verify_text = read_text(verify_path)
    result, fallback_to, failure_category, reason = parse_verify_result(verify_text)

    if result == "PASS":
        state.set_workflow(
            phase="complete",
            status="completed",
            result="PASS",
            current_step="complete",
            next_step="none",
            manual_review_required=False,
            retryable=False,
            failure_category="none",
            reason=reason or "VERIFY フェーズ完了",
            fallback_to="",
            blockers=[]
        )
        state.data["承認"]["検証確認"] = True
        state.append_history("verify_completed", {"result": "PASS"})
        state.save()
        logger.info("VERIFY フェーズ完了。結果: PASS")
        return

    if result == "FAIL":
        state.set_workflow(
            phase="verify",
            status="completed",
            result="FAIL",
            current_step="verify",
            next_step="human_review" if failure_category in ("environment", "approval", "unknown") else "patch_retry",
            manual_review_required=failure_category in ("environment", "approval", "unknown"),
            retryable=failure_category == "implementation",
            failure_category=failure_category,
            reason=reason or "VERIFY.md にて FAIL 判定",
            fallback_to=fallback_to or FAILURE_TO_FALLBACK.get(failure_category, "Codex"),
            blockers=["VERIFY.md にて FAIL 判定"]
        )
        state.append_history("verify_completed", {
            "result": "FAIL",
            "fallback_to": fallback_to or FAILURE_TO_FALLBACK.get(failure_category, "Codex"),
            "failure_category": failure_category,
        })
        state.save()
        logger.warn(f"VERIFY フェーズ完了。結果: FAIL / 戻し先: {fallback_to or FAILURE_TO_FALLBACK.get(failure_category, 'Codex')}")
        return

    state.set_workflow(
        phase="verify",
        status="completed",
        result="UNKNOWN",
        current_step="verify",
        next_step="human_review",
        manual_review_required=True,
        retryable=False,
        failure_category="unknown",
        reason=reason or "VERIFY.md から PASS/FAIL を自動判定できませんでした",
        fallback_to="Human",
        blockers=["VERIFY.md から PASS/FAIL を自動判定できませんでした"]
    )
    state.append_history("verify_completed", {"result": "UNKNOWN"})
    state.save()
    logger.warn("VERIFY.md から PASS/FAIL を自動判定できませんでした。Human確認が必要です。")


def run_orchestrator(project_root: Path, state_path: Path, dry_run_override: Optional[bool] = None) -> int:
    """オーケストレーター本体。"""
    log_file = project_root / "logs" / "bootstrap" / "orchestrator.log"
    logger = Logger(log_file=log_file)

    state = StateManager(state_path=state_path, logger=logger)
    run_id = state.prepare_run()
    logger = Logger(log_file=project_root / "logs" / run_id / "orchestrator.log")
    state.logger = logger

    logger.info("orchestrator 開始")
    logger.info(f"project_root = {project_root}")
    logger.info(f"state_path = {state_path}")
    logger.info(f"run_id = {run_id}")

    if dry_run_override is not None:
        state.data.setdefault("automation", {})["dry_run"] = dry_run_override
    dry_run = bool(state.get_automation_flag("dry_run", False))
    max_step_count = int(state.get_automation_flag("max_step_count", 10))
    try_count = int(state.data.get("実行管理", {}).get("試行回数", 0))
    max_try_count = int(state.data.get("実行管理", {}).get("最大試行回数", 3))

    if not bool(state.get_automation_flag("enabled", True)):
        logger.warn("automation.enabled = false のため終了します。")
        return 0

    if try_count >= max_try_count or try_count >= max_step_count:
        state.set_workflow(
            phase="human_review",
            status="stopped",
            result="FAIL",
            current_step="human_review",
            next_step="none",
            manual_review_required=True,
            retryable=False,
            failure_category="approval",
            reason="試行回数が上限を超えたため停止",
            fallback_to="Human",
            blockers=["試行回数が上限を超えました"]
        )
        state.data["次のアクション"] = "Human が失敗履歴と承認状態を確認し、再実行可否を判断する"
        state.append_history("run_stopped_max_count", {"run_id": run_id, "try_count": try_count})
        update_current_status(project_root, state)
        state.save()
        logger.warn("試行回数が上限を超えたため停止します。")
        return 1

    try_count = state.increment_try_count()
    state.save()

    # 成果物存在フラグ更新
    update_artifacts_existence(project_root, state)
    state.save()

    design_path = state.get_artifact_path(project_root, "design")
    patch_path = state.get_artifact_path(project_root, "patch")
    verify_path = state.get_artifact_path(project_root, "verify")

    logger.info(f"DESIGN.md = {design_path}")
    logger.info(f"PATCH.md  = {patch_path}")
    logger.info(f"VERIFY.md = {verify_path}")

    design_approved = sync_design_approval_from_document(project_root, state, logger)
    if design_approved:
        state.save()

    # 設計承認待ち
    if not artifact_is_ready(design_path, "design"):
        state.set_workflow(
            phase="design",
            status="waiting",
            result="pending",
            current_step="design",
            next_step="design",
            manual_review_required=False,
            retryable=False,
            failure_category="design",
            reason="DESIGN.md が未作成、空、または雛形のままです",
            fallback_to="Gemini",
            blockers=["DESIGN.md が未作成、空、または雛形のままです"]
        )
        state.data["次のアクション"] = "Gemini と Human が DESIGN.md を完成させ、設計承認を更新する"
        state.append_history("waiting_design", {})
        update_current_status(project_root, state)
        state.save()
        logger.warn("DESIGN.md が未準備のため終了します。")
        return 1

    if not design_approved:
        if dry_run:
            logger.warn("設計承認は未完了ですが、dry-run のためコマンド確認のみ継続します。")
            state.set_workflow(
                phase="design",
                status="dry_run_waiting_approval",
                result="pending",
                current_step="design",
                next_step="human_approval",
                manual_review_required=True,
                retryable=True,
                failure_category="approval",
                reason="設計承認は未完了だが dry-run のため後続コマンド確認を許可",
                fallback_to="Human",
                blockers=["設計承認が未完了です"]
            )
            state.data["次のアクション"] = "dry-run の確認後、Human が設計承認=true に更新して本実行する"
            state.append_history("dry_run_without_design_approval", {})
            update_current_status(project_root, state)
            state.save()
        else:
            state.set_workflow(
                phase="design",
                status="waiting_approval",
                result="pending",
                current_step="design",
                next_step="human_approval",
                manual_review_required=True,
                retryable=False,
                failure_category="approval",
                reason="設計承認が未完了です",
                fallback_to="Human",
                blockers=["設計承認が未完了です"]
            )
            state.data["次のアクション"] = "Human が DESIGN.md をレビューし、設計承認=true に更新する"
            state.append_history("waiting_design_approval", {})
            update_current_status(project_root, state)
            state.save()
            logger.warn("設計承認が無いため終了します。")
            return 1

    try:
        # PATCH が未完了なら実行
        if not artifact_is_ready(patch_path, "patch"):
            logger.info("PATCH.md が未作成のため、Codex フェーズへ進みます。")
            do_patch(project_root, state, logger)
        else:
            logger.info("PATCH.md は既に存在します。Codex フェーズをスキップします。")
            state.data["承認"]["実装承認"] = True
            state.set_workflow(
                phase="patch",
                status="completed",
                result="PASS",
                current_step="patch",
                next_step="verify",
                manual_review_required=False,
                retryable=False,
                failure_category="none",
                reason="既存 PATCH.md を再利用",
                fallback_to="",
                blockers=[]
            )
            update_artifacts_existence(project_root, state)
            state.save()

        # VERIFY が未完了なら実行
        if not artifact_is_ready(verify_path, "verify"):
            logger.info("VERIFY.md が未作成のため、Claude フェーズへ進みます。")
            do_verify(project_root, state, logger)
        else:
            logger.info("VERIFY.md は既に存在します。Claude フェーズをスキップします。")
            verify_text = read_text(verify_path)
            result, fallback_to, failure_category, reason = parse_verify_result(verify_text)
            if result == "PASS":
                state.set_workflow(
                    phase="complete",
                    status="completed",
                    result="PASS",
                    current_step="complete",
                    next_step="none",
                    manual_review_required=False,
                    retryable=False,
                    failure_category="none",
                    reason=reason or "既存 VERIFY.md は PASS 判定",
                    fallback_to="",
                    blockers=[]
                )
            elif result == "FAIL":
                state.set_workflow(
                    phase="verify",
                    status="completed",
                    result="FAIL",
                    current_step="verify",
                    next_step="human_review" if failure_category in ("environment", "approval", "unknown") else "patch_retry",
                    manual_review_required=failure_category in ("environment", "approval", "unknown"),
                    retryable=failure_category == "implementation",
                    failure_category=failure_category,
                    reason=reason or "既存の VERIFY.md は FAIL 判定です",
                    fallback_to=fallback_to or FAILURE_TO_FALLBACK.get(failure_category, "Codex"),
                    blockers=["既存の VERIFY.md は FAIL 判定です"]
                )
            else:
                state.set_workflow(
                    phase="verify",
                    status="completed",
                    result="UNKNOWN",
                    current_step="verify",
                    next_step="human_review",
                    manual_review_required=True,
                    retryable=False,
                    failure_category="unknown",
                    reason="既存の VERIFY.md を自動判定できません",
                    fallback_to="Human",
                    blockers=["既存の VERIFY.md を自動判定できません"]
                )
            state.data["次のアクション"] = state.data["ワークフロー状態"].get("次ステップ", "none")
            update_current_status(project_root, state)
            state.save()

        if dry_run:
            state.data["次のアクション"] = "dry-run 確認後、必要なら本実行する"
            update_current_status(project_root, state)
            state.save()
            logger.info("orchestrator dry-run 正常終了")
            return 0

        state.data["次のアクション"] = state.data["ワークフロー状態"].get("次ステップ", "none")
        update_current_status(project_root, state)
        state.save()
        logger.info("orchestrator 正常終了")
        return 0

    except Exception as e:
        tb = traceback.format_exc()
        logger.error(str(e))
        logger.error(tb)

        # 最低限の異常記録
        existing_failure_category = state.data.get("ワークフロー状態", {}).get("失敗分類", "unknown")
        existing_fallback_to = state.data.get("ワークフロー状態", {}).get("戻し先", "Human")
        state.append_history("orchestrator_exception", {
            "error": str(e),
            "traceback": tb
        })
        state.set_workflow(
            current_step="human_review",
            next_step="human_review",
            manual_review_required=True,
            retryable=False,
            failure_category=existing_failure_category or "unknown",
            reason=str(e),
            status="failed",
            result="FAIL",
            fallback_to=existing_fallback_to or "Human",
            blockers=[str(e)]
        )
        state.data["次のアクション"] = "Human がログと state を確認し、再実行条件を整理する"
        update_current_status(project_root, state)
        state.save()
        return 2


# =========================
# CLI引数
# =========================

def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="DESIGN/PATCH/VERIFY ワークフロー用オーケストレーター"
    )
    parser.add_argument(
        "--project-root",
        default=".",
        help="プロジェクトルートディレクトリ。既定値: カレントディレクトリ"
    )
    parser.add_argument(
        "--state",
        default="state_compact.json",
        help="state_compact.json のパス。既定値: state_compact.json"
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="外部CLIを実行せず、実行予定コマンドだけを出力する"
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    project_root = Path(args.project_root).resolve()
    state_path = Path(args.state).resolve()

    # --state が相対パスなら project_root 基準に寄せたい場合は下のように変更可
    # if not Path(args.state).is_absolute():
    #     state_path = (project_root / args.state).resolve()

    return run_orchestrator(
        project_root=project_root,
        state_path=state_path,
        dry_run_override=args.dry_run
    )


if __name__ == "__main__":
    sys.exit(main())
