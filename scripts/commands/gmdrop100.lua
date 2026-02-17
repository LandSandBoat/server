-----------------------------------
-- func: gmdrop100
-- desc: GMが攻撃(与ダメージ)した敵のみ、通常ドロップを100%にする機能のON/OFF
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local KEY = 'GMDROP100_ENABLED'

-- クライアント側の文字化け対策として Shift_JIS バイト列を直接埋め込む
local MSG_STATUS_FMT = string.char(
    0x47, 0x4D, 0x83, 0x68, 0x83, 0x8D, 0x83, 0x62, 0x83, 0x76, 0x31, 0x30, 0x30, 0x25, 0x25, 0x3A, 0x20, 0x25, 0x73
)
local MSG_INVALID_ARG = string.char(
    0x88, 0xF8, 0x90, 0x94, 0x82, 0xAA, 0x95, 0x73, 0x90, 0xB3, 0x82, 0xC5, 0x82, 0xB7, 0x81, 0x42
)

local function getEnabled()
    return (GetVolatileServerVariable(KEY) or 0) ~= 0
end

local function setEnabled(enabled)
    SetVolatileServerVariable(KEY, enabled and 1 or 0)
end

local function printUsage(player)
    player:printToPlayer('!gmdrop100 [on|off|toggle]')
end

commandObj.onTrigger = function(player, arg1)
    if arg1 == nil then
        player:printToPlayer(string.format(MSG_STATUS_FMT, getEnabled() and 'ON' or 'OFF'))
        printUsage(player)
        return
    end

    local a = string.lower(tostring(arg1))

    if a == 'on' then
        setEnabled(true)
    elseif a == 'off' then
        setEnabled(false)
    elseif a == 'toggle' then
        setEnabled(not getEnabled())
    else
        player:printToPlayer(MSG_INVALID_ARG)
        printUsage(player)
        return
    end

    player:printToPlayer(string.format(MSG_STATUS_FMT, getEnabled() and 'ON' or 'OFF'))
end

return commandObj
