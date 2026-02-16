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
        player:printToPlayer(string.format('GMドロップ100%%: %s', getEnabled() and 'ON' or 'OFF'))
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
        player:printToPlayer('引数が不正です。')
        printUsage(player)
        return
    end

    player:printToPlayer(string.format('GMドロップ100%%: %s', getEnabled() and 'ON' or 'OFF'))
end

return commandObj

