-----------------------------------
-- func: bazaar
-- auth: Run_Away
-- desc: Teleports a player to the Bazaar zone (222).
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

commandObj.onTrigger = function(player)
    if player:getAnimation() == xi.animation.SYNTH then
        player:printToPlayer('You cannot do that while crafting. Cheater.')
        return
    end

    local zone = player:getZone():getID()
    local prevZone = player:getPreviousZone()

    if
        zone == xi.zone.NORTHERN_SAN_DORIA or zone == xi.zone.AHT_URHGAN_WHITEGATE or zone == xi.zone.NASHMAU or zone == xi.zone.SOUTHERN_SAN_DORIA or
        zone == xi.zone.PORT_SAN_DORIA or zone == xi.zone.CHATEAU_DORAGUILLE or zone == xi.zone.BASTOK_MINES or zone == xi.zone.BASTOK_MARKETS or
        zone == xi.zone.PORT_BASTOK or zone == xi.zone.METALWORKS or zone == xi.zone.WINDURST_WATERS or zone == xi.zone.WINDURST_WALLS or
        zone == xi.zone.PORT_WINDURST or zone == xi.zone.WINDURST_WOODS or zone == xi.zone.HEAVENS_TOWER or zone == xi.zone.RULUDE_GARDENS or
        zone == xi.zone.UPPER_JEUNO or zone == xi.zone.LOWER_JEUNO or zone == xi.zone.PORT_JEUNO or zone == xi.zone.RABAO or
        zone == xi.zone.AL_ZAHBI
    then
        player:setPos(0, 0, 0, 0, xi.zone.PROVENANCE)
    elseif zone == xi.zone.PROVENANCE and prevZone ~= nil then
        player:setPos(0, 0, 0, 0, prevZone)
    else
        player:printToPlayer('I\'m sorry, Dave. I\'m afraid I can\'t do that.')
    end
end

return commandObj
