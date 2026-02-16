-----------------------------------
-- func: ahpostwl
-- desc: ホワイトリストにあるアイテムをインベントリから探して、1ギルで競売へ一括出品する（GM用）
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

-- 出品したいアイテムIDをここに追加してください。
-- 例: デオドライザー(4166) を出品する場合は `4166,` を追加。
--
-- IDだけでなく、名前でも指定できます:
-- - 数値: itemId として扱う
-- - 文字列:
--   - 日本語名（例: 'プラチナインゴット'）: `scripts/globals/item_name_ja.lua` の辞書で解決
--   - `xi.item` のキー（例: 'PLATINUM_INGOT'）なら `xi.item[<key>]` で解決
--   - それ以外は `GetItemIDByName('platinum_ingot')` のようなDB名で解決
local WHITELIST =
{
    -- 4166,
    922,924,930,637,647,748,749,750,881,891,914,921,926,939,1237,16995,17316,17303,645,702,896,897,916,928,1116,
    1118,1119,1121,1163,
    -- 合成素材売り
    'ビロード',
}

-- FFXIクライアント側の文字コード（CP932/Shift_JIS）に合わせて日本語を表示するため、
-- Lua内に日本語文字列を直書きせず、CP932のバイト列で組み立てる。
local function cp932(...)
    return string.char(...)
end

local MSG_PREFIX    = cp932(0x8B,0xA3,0x94,0x84,0x8F,0x6F,0x95,0x69,0x3A,0x20) -- "競売出品: "
local MSG_STACK     = cp932(0x83,0x58,0x83,0x5E,0x83,0x62,0x83,0x4E,0x3D)       -- "スタック="
local MSG_SINGLE    = cp932(0x20,0x2F,0x20,0x92,0x50,0x95,0x69,0x3D)             -- " / 単品="
local MSG_SKIP      = cp932(0x20,0x2F,0x20,0x83,0x58,0x83,0x4C,0x83,0x62,0x83,0x76,0x3D) -- " / スキップ="
local MSG_FAIL      = cp932(0x20,0x2F,0x20,0x8E,0xB8,0x94,0x73,0x3D)             -- " / 失敗="
local MSG_WL_PREFIX = cp932(0x20,0x28,0x77,0x68,0x69,0x74,0x65,0x6C,0x69,0x73,0x74,0x3D) -- " (whitelist="
local MSG_PRICE     = cp932(0x20,0x2F,0x20,0x70,0x72,0x69,0x63,0x65,0x3D)        -- " / price="
local MSG_RPAREN    = cp932(0x29)                                                 -- ")"

local function nstr(v)
    return tostring(tonumber(v) or 0)
end

local function resolveWhitelist(player, raw)
    local out = {}
    local bad = {}

    local function trim(s)
        -- Also trim full-width spaces (U+3000) by treating them as spaces.
        s = s:gsub("　", " ")
        s = s:gsub("^%s+", ""):gsub("%s+$", "")
        return s
    end

    local function consume(v)
        local t = type(v)
        if t == 'number' then
            table.insert(out, v)
            return
        end

        if t ~= 'string' then
            table.insert(bad, string.format('invalid type \"%s\"', t))
            return
        end

        local s = trim(v)
        local asNum = tonumber(s)
        if asNum ~= nil then
            table.insert(out, asNum)
            return
        end

        -- Japanese display-name lookup (generated from data/ID/*.md)
        if xi ~= nil and xi.jpItemNameToId ~= nil then
            local jp = xi.jpItemNameToId[s]
            if type(jp) == 'number' then
                table.insert(out, jp)
                return
            elseif type(jp) == 'table' then
                table.insert(bad, string.format('ambiguous jp \"%s\" (%u matches)', s, #jp))
                return
            end
        end

        if xi ~= nil and xi.item ~= nil and xi.item[s] ~= nil then
            table.insert(out, xi.item[s])
            return
        end

        if type(GetItemIDByName) ~= 'function' then
            table.insert(bad, string.format('cannot resolve \"%s\" (GetItemIDByName missing)', s))
            return
        end

        local retItem = GetItemIDByName(s)
        if retItem > 0 and retItem < 65000 then
            table.insert(out, retItem)
        elseif retItem >= 65000 then
            table.insert(bad, string.format('ambiguous \"%s\" (%u matches)', s, 65536 - retItem))
        else
            table.insert(bad, string.format('not found \"%s\"', s))
        end
    end

    -- Accept both array style: { 746, "platinum_ingot" } and set style: { [746]=true, platinum_ingot=true }
    for k, v in pairs(raw) do
        if type(v) == 'boolean' and v == true then
            consume(k)
        else
            consume(v)
        end
    end

    if #bad > 0 then
        -- Keep it ASCII to avoid encoding issues in chat/logs.
        player:printToPlayer('ahpostwl: whitelist resolve errors:')
        for _, msg in ipairs(bad) do
            player:printToPlayer('  - ' .. msg)
        end
    end

    return out
end

local MSG_WL_EMPTY = cp932(
    0x57,0x48,0x49,0x54,0x45,0x4C,0x49,0x53,0x54,0x20,0x82,0xAA,0x8B,0xF3,0x82,0xC5,0x82,0xB7,0x81,0x42,
    0x73,0x63,0x72,0x69,0x70,0x74,0x73,0x2F,0x63,0x6F,0x6D,0x6D,0x61,0x6E,0x64,0x73,0x2F,0x61,0x68,0x70,0x6F,0x73,0x74,0x77,0x6C,0x2E,0x6C,0x75,0x61,0x20,
    0x82,0xCC,0x20,0x57,0x48,0x49,0x54,0x45,0x4C,0x49,0x53,0x54,0x20,0x82,0xC9,0x20,0x69,0x74,0x65,0x6D,0x49,0x64,0x20,0x82,0xF0,0x92,0xC7,0x89,0xC1,0x82,0xB5,0x82,0xC4,0x82,0xAD,0x82,0xBE,0x82,0xB3,0x82,0xA2,0x81,0x42
)
local MSG_FAILED_PREFIX = cp932(0x8B,0xA3,0x94,0x84,0x8F,0x6F,0x95,0x69,0x82,0xC9,0x8E,0xB8,0x94,0x73,0x82,0xB5,0x82,0xDC,0x82,0xB5,0x82,0xBD,0x3A,0x20) -- "競売出品に失敗しました: "

commandObj.onTrigger = function(player)
    if next(WHITELIST) == nil then
        player:printToPlayer(MSG_WL_EMPTY)
        return
    end

    local resolved = resolveWhitelist(player, WHITELIST)
    if #resolved == 0 then
        player:printToPlayer('ahpostwl: resolved whitelist is empty')
        return
    end

    local r = player:ahPostWhitelist(resolved, 1)

    if r.error ~= nil then
        player:printToPlayer(MSG_FAILED_PREFIX .. tostring(r.error))
        return
    end

    player:printToPlayer(
        MSG_PREFIX ..
        MSG_STACK .. nstr(r.posted_stacks) ..
        MSG_SINGLE .. nstr(r.posted_singles) ..
        MSG_SKIP .. nstr(r.skipped) ..
        MSG_FAIL .. nstr(r.failed) ..
        MSG_WL_PREFIX .. nstr(r.whitelist_count) ..
        MSG_PRICE .. nstr(r.price) ..
        MSG_RPAREN
    )
end

return commandObj
