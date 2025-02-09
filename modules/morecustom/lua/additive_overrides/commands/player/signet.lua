-----------------------------------
-- func: signet
-- desc: Casts signet on the player.
-----------------------------------

local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = "is"
}

local allowedZones =
{
    xi.zone.PORT_SAN_DORIA,
    xi.zone.NORTHERN_SAN_DORIA,
    xi.zone.SOUTHERN_SAN_DORIA,
    xi.zone.PORT_BASTOK,
    xi.zone.BASTOK_MINES,
    xi.zone.BASTOK_MARKETS,
    xi.zone.WINDURST_WATERS,
    xi.zone.PORT_WINDURST,
    xi.zone.WINDURST_WALLS,
    xi.zone.WINDURST_WOODS,
    xi.zone.SELBINA,
    xi.zone.RABAO,
    xi.zone.NORG,
    xi.zone.RULUDE_GARDENS,
    xi.zone.UPPER_JEUNO,
    xi.zone.LOWER_JEUNO,
    xi.zone.PORT_JEUNO,
    xi.zone.METALWORKS,
    xi.zone.MHAURA,
    xi.zone.KAZHAM,
}

commandObj.onTrigger = function(player)
    local currentZone = player:getZoneID()
    player:printToPlayer("NOTE: This command may only be used in cities.")

    for _, allowedZone in ipairs(allowedZones) do
        if currentZone == allowedZone then
            player:printToPlayer("Enjoy signet!")
            player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
            player:addStatusEffect(xi.effect.SIGNET, 0, 0, 15000)
        end
    end
end

return commandObj
