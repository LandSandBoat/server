-----------------------------------
-- func: !relic
-- desc: Print the time left till a player can pick up their relic.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = ''
}

local function convertTimeRemainingToString(timeRemaining)
    -- Round up to the nearest minute.
    timeRemaining = timeRemaining + 59

    local days    = math.floor(timeRemaining / 86400)
    local hours   = math.floor((timeRemaining / 3600) - (days * 24))
    local minutes = math.floor((timeRemaining / 60) - (hours * 60) - (days * 1440))

    return string.format('%sd %sh %sm', days, hours, minutes)
end

commandObj.onTrigger = function(player)
    local relicDue = player:getVar('RELIC_DUE_AT')
    local time     = GetSystemTime()

    if relicDue > 0 and relicDue < time then
        player:printToPlayer('Your relic is done!')
    elseif relicDue > 0 then
        local durationString = convertTimeRemainingToString(relicDue - time)
        player:printToPlayer(string.format('You can pick up your relic in: %s.', durationString))
    else
        player:printToPlayer('No relic in progress.')
    end
end

return commandObj
