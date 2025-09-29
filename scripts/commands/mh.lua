-----------------------------------
-- func: mh
-- desc: Opens the mog house menu in valid zones (or anywhere as GM)
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

commandObj.onTrigger = function(player, npc)
    if player:getAnimation() == xi.animation.SYNTH then
        player:printToPlayer('You cannot do that while crafting.')
        return
    end

    local validZones =
    {
        [xi.zone.TAVNAZIAN_SAFEHOLD] = true,
        [xi.zone.AL_ZAHBI] = true,
        [xi.zone.AHT_URHGAN_WHITEGATE] = true,
        [xi.zone.NASHMAU] = true,
        [xi.zone.SOUTHERN_SAN_DORIA_S] = true,
        [xi.zone.BASTOK_MARKETS_S] = true,
        [xi.zone.WINDURST_WATERS_S] = true,
        [xi.zone.PROVENANCE] = true,
        [xi.zone.SOUTHERN_SAN_DORIA] = true,
        [xi.zone.NORTHERN_SAN_DORIA] = true,
        [xi.zone.PORT_SAN_DORIA] = true,
        [xi.zone.CHATEAU_DORAGUILLE] = true,
        [xi.zone.BASTOK_MINES] = true,
        [xi.zone.BASTOK_MARKETS] = true,
        [xi.zone.PORT_BASTOK] = true,
        [xi.zone.METALWORKS] = true,
        [xi.zone.WINDURST_WATERS] = true,
        [xi.zone.WINDURST_WALLS] = true,
        [xi.zone.PORT_WINDURST] = true,
        [xi.zone.WINDURST_WOODS] = true,
        [xi.zone.HEAVENS_TOWER] = true,
        [xi.zone.RULUDE_GARDENS] = true,
        [xi.zone.UPPER_JEUNO] = true,
        [xi.zone.LOWER_JEUNO] = true,
        [xi.zone.PORT_JEUNO] = true,
        [xi.zone.RABAO] = true,
        [xi.zone.SELBINA] = true,
        [xi.zone.MHAURA] = true,
        [xi.zone.KAZHAM] = true,
        [xi.zone.NORG] = true,
    }

    if
        player:getGMLevel() == 0 and
        not validZones[player:getZoneID()]
    then
        player:printToPlayer('You cannot use that command here.')
        return
    end

    return player:sendMenu(1)
end

return commandObj
