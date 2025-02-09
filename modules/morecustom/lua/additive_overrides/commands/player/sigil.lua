-----------------------------------
-- func: sigil
-- desc: Casts sigil on the player.
-----------------------------------

local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = "is"
}

local allowedZones =
{
    xi.zone.SOUTHERN_SAN_DORIA_S,
    xi.zone.BASTOK_MARKETS_S,
    xi.zone.WINDURST_WATERS_S,
}

commandObj.onTrigger = function(player)
    local currentZone = player:getZoneID()
    player:printToPlayer("NOTE: This command may only be used in cities.")

    for _, allowedZone in ipairs(allowedZones) do
        if currentZone == allowedZone then
            player:printToPlayer("Enjoy sigil!")
            player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
            player:addStatusEffect(xi.effect.SIGIL, 0, 0, 15000)
        end
    end
end

return commandObj
