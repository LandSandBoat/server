-----------------------------------
-- func: time
-- desc: Sets the custom time offset of the CVanaTime instance.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 4,
    parameters = 'i'
}

local function error(player)
    player:printToPlayer('!time <offset>')
    player:printToPlayer(string.format('Vana\'diel: %d/%d/%d/%d/%02d', VanadielYear(), VanadielMonth(), VanadielDayOfTheMonth(), VanadielHour(), VanadielMinute()))
end

commandObj.onTrigger = function(player, offset)
    -- validate offset
    if offset == nil then
        error(player)
        return
    end

    -- time offset
    local result = SetVanadielTimeOffset(offset)
    if result == nil then
        error(player)
        return
    else
        player:printToPlayer('Time changed!')
        player:printToPlayer(string.format('Vana\'diel: %d/%d/%d/%d/%02d', VanadielYear(), VanadielMonth(), VanadielDayOfTheMonth(), VanadielHour(), VanadielMinute()))
    end
end

return commandObj
