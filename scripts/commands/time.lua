-----------------------------------
-- func: time
-- desc: Sets the custom time offset of the CVanaTime instance.
-----------------------------------

cmdprops =
{
    permission = 4,
    parameters = 'i'
}

function error(player)
    player:PrintToPlayer('!time <offset>')
    player:PrintToPlayer(string.format('Vana\'diel: %d/%d/%d/%d/%02d', VanadielYear(), VanadielMonth(), VanadielDayOfTheMonth(), VanadielHour(), VanadielMinute()))
end

function onTrigger(player, offset)
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
