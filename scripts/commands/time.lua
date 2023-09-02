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
    player:PrintToPlayer('!time <offset>')
    player:PrintToPlayer(string.format('Vana\'diel: %d/%d/%d/%d/%02d', VanadielYear(), VanadielMonth(), VanadielDayOfTheMonth(), VanadielHour(), VanadielMinute()))
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
        player:PrintToPlayer('Time changed!')
        player:PrintToPlayer(string.format('Vana\'diel: %d/%d/%d/%d/%02d', VanadielYear(), VanadielMonth(), VanadielDayOfTheMonth(), VanadielHour(), VanadielMinute()))
    end
end

return commandObj
