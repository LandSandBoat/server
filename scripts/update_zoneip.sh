#!/usr/bin/env bash
set -Eeuo pipefail

# zone_settings の zoneip を外部IPへ追従させる自動更新スクリプト。
# - 複数の外部IP取得先を順に試す
# - zone_settings に複数IPが混在していたら安全側で停止する
# - DB更新後に必要サービスを順番に再起動する
# - 再起動に失敗した場合は旧IPへ戻し、旧設定での復旧確認まで行う

readonly SCRIPT_PATH="$(readlink -f "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly DEFAULT_ENV_FILES=(
    "$PROJECT_ROOT/.env.zoneip_update"
    "$PROJECT_ROOT/.env"
)
readonly DEFAULT_IP_SOURCES=(
    "https://ifconfig.me"
    "https://ident.me"
    "https://api.ipify.org"
)
readonly DEFAULT_RESTART_SERVICES=(
    "xi-world.service"
    "xi-map.service"
    "xi-connect.service"
)

ZONEIP_DB_NAME="${ZONEIP_DB_NAME:-xidb}"
ZONEIP_DB_HOST="${ZONEIP_DB_HOST:-localhost}"
ZONEIP_DB_PORT="${ZONEIP_DB_PORT:-3306}"
ZONEIP_LOCK_FILE="${ZONEIP_LOCK_FILE:-/var/lock/ffxi_zoneip_update.lock}"
ZONEIP_CURL_MAX_TIME="${ZONEIP_CURL_MAX_TIME:-10}"
ZONEIP_LOG_PREFIX="${ZONEIP_LOG_PREFIX:-[update_zoneip]}"

log() {
    printf '%s %s\n' "$ZONEIP_LOG_PREFIX" "$*" >&2
}

warn() {
    log "WARN: $*"
}

error() {
    log "ERROR: $*" >&2
}

is_valid_ipv4() {
    local ip="$1"
    local -a octets=()
    local octet

    [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || return 1
    IFS='.' read -r -a octets <<< "$ip"
    [[ "${#octets[@]}" -eq 4 ]] || return 1

    for octet in "${octets[@]}"; do
        [[ "$octet" =~ ^[0-9]{1,3}$ ]] || return 1
        ((octet >= 0 && octet <= 255)) || return 1
    done

    return 0
}

load_env_files() {
    local env_file
    for env_file in "${DEFAULT_ENV_FILES[@]}"; do
        if [[ -f "$env_file" ]]; then
            # shellcheck disable=SC1090
            source "$env_file"
            log "設定ファイルを読み込みました: $env_file"
        fi
    done
}

build_mysql_command() {
    MYSQL_CMD=("mysql" "--batch" "--skip-column-names" "--raw")

    if [[ -n "${ZONEIP_DB_HOST:-}" ]]; then
        MYSQL_CMD+=("--host=$ZONEIP_DB_HOST")
    fi
    if [[ -n "${ZONEIP_DB_PORT:-}" ]]; then
        MYSQL_CMD+=("--port=$ZONEIP_DB_PORT")
    fi
    if [[ -n "${ZONEIP_DB_USER:-}" ]]; then
        MYSQL_CMD+=("--user=$ZONEIP_DB_USER")
    fi

    MYSQL_CMD+=("$ZONEIP_DB_NAME")
}

mysql_query() {
    local query="$1"

    if [[ -n "${ZONEIP_DB_PASS:-}" ]]; then
        MYSQL_PWD="$ZONEIP_DB_PASS" "${MYSQL_CMD[@]}" --execute="$query"
    else
        "${MYSQL_CMD[@]}" --execute="$query"
    fi
}

get_ip_sources() {
    if [[ -n "${ZONEIP_IP_SOURCES:-}" ]]; then
        # 環境変数で順序を上書きしたい場合に備え、空白区切りで解釈する。
        read -r -a IP_SOURCES <<< "$ZONEIP_IP_SOURCES"
    else
        IP_SOURCES=("${DEFAULT_IP_SOURCES[@]}")
    fi
}

get_restart_services() {
    if [[ -n "${ZONEIP_RESTART_SERVICES:-}" ]]; then
        # 空白区切りで順序を受け取り、そのまま再起動順として使う。
        read -r -a RESTART_SERVICES <<< "$ZONEIP_RESTART_SERVICES"
    else
        RESTART_SERVICES=("${DEFAULT_RESTART_SERVICES[@]}")
    fi
}

detect_public_ip() {
    local source
    local candidate

    for source in "${IP_SOURCES[@]}"; do
        candidate="$(curl -fsS --max-time "$ZONEIP_CURL_MAX_TIME" "$source" 2>/dev/null | tr -d '\r\n[:space:]' || true)"
        if [[ -z "$candidate" ]]; then
            warn "外部IP取得に失敗しました: $source"
            continue
        fi
        if ! is_valid_ipv4 "$candidate"; then
            warn "外部IP取得結果が IPv4 形式ではありません: $source -> $candidate"
            continue
        fi

        log "外部IPを取得しました: $candidate (source: $source)"
        printf '%s\n' "$candidate"
        return 0
    done

    return 1
}

get_current_zoneip() {
    local distinct_output
    local line_count

    distinct_output="$(mysql_query "SELECT DISTINCT zoneip FROM zone_settings WHERE zoneip <> '' ORDER BY zoneip;")"
    line_count="$(printf '%s\n' "$distinct_output" | sed '/^$/d' | wc -l)"

    if [[ "$line_count" -eq 0 ]]; then
        error "zone_settings に有効な zoneip が見つかりません。"
        return 1
    fi

    if [[ "$line_count" -ne 1 ]]; then
        error "zone_settings に複数の zoneip が混在しています。自動更新を中止します。"
        printf '%s\n' "$distinct_output" | sed '/^$/d' | while IFS= read -r line; do
            error "検出した zoneip: $line"
        done
        return 1
    fi

    printf '%s\n' "$distinct_output" | sed '/^$/d'
}

update_zoneip() {
    local new_ip="$1"
    mysql_query "UPDATE zone_settings SET zoneip='${new_ip}';"
}

restart_services() {
    local stage="$1"
    local service

    for service in "${RESTART_SERVICES[@]}"; do
        log "$stage: サービスを再起動します: $service"
        if ! systemctl restart "$service"; then
            error "$stage: サービス再起動に失敗しました: $service"
            return 1
        fi
        if ! systemctl is-active --quiet "$service"; then
            error "$stage: サービスが active ではありません: $service"
            return 1
        fi
    done

    return 0
}

ensure_commands() {
    local command_name
    for command_name in curl mysql systemctl flock; do
        command -v "$command_name" >/dev/null 2>&1 || {
            error "必要コマンドが見つかりません: $command_name"
            exit 1
        }
    done
}

main() {
    local current_ip
    local detected_ip

    mkdir -p "$(dirname "$ZONEIP_LOCK_FILE")"
    exec 9>"$ZONEIP_LOCK_FILE"
    if ! flock -n 9; then
        warn "既に別の update_zoneip.sh が動作中のため、今回の実行をスキップします。"
        exit 0
    fi

    load_env_files
    ensure_commands
    build_mysql_command
    get_ip_sources
    get_restart_services

    current_ip="$(get_current_zoneip)"
    detected_ip="$(detect_public_ip | tail -n 1)" || {
        error "有効な外部IPを取得できませんでした。"
        exit 1
    }

    if [[ "$current_ip" == "$detected_ip" ]]; then
        log "zoneip は最新です。更新不要: $current_ip"
        exit 0
    fi

    log "zoneip を更新します: $current_ip -> $detected_ip"
    update_zoneip "$detected_ip"

    if restart_services "新IP反映"; then
        log "zoneip 更新とサービス再起動が完了しました。"
        exit 0
    fi

    warn "新IP反映に失敗したため、旧IPへロールバックします。"
    update_zoneip "$current_ip"

    if restart_services "ロールバック復旧"; then
        error "新IP反映に失敗したため、旧IPへロールバックして復旧しました。"
        exit 1
    fi

    error "旧IPへのロールバック後もサービス復旧に失敗しました。手動確認が必要です。"
    exit 1
}

main "$@"
