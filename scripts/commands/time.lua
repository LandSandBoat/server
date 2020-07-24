---------------------------------------------------------------------------------------------------
-- func: time
-- desc: Sets the custom time offset of the CVanaTime instance.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = "i"
}

function error(player)
    player:PrintToPlayer("!time <offset>")
    player:PrintToPlayer("Vana'diel: "..VanadielYear().."/"..VanadielMonth().."/"..VanadielDayOfTheMonth()..", "..VanadielHour()..":"..string.format("%02d", VanadielMinute()))
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
        player:PrintToPlayer("Time changed!")
        player:PrintToPlayer("Vana'diel: "..VanadielYear().."/"..VanadielMonth().."/"..VanadielDayOfTheMonth()..", "..VanadielHour()..":"..string.format("%02d", VanadielMinute()))
    end
end
