cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!spawndynawave <wave number>")
end

function onTrigger(player, wave)
    if (wave == nil) then
        error(player, "You must enter a valid spawn wave.")
        return
    end

    if not player:isInDynamis() then
        return
    end

    -- push visual packet to player
    xi.dynamis.spawnWave(player:getZone(), player:getZoneID(), wave)
end
