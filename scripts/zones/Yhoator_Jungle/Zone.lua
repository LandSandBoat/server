-----------------------------------
-- Zone: Yhoator_Jungle (124)
-----------------------------------
local ID = zones[xi.zone.YHOATOR_JUNGLE]
require('scripts/missions/amk/helpers')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.conquest.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helmType.HARVESTING)
    xi.helm.initZone(zone, xi.helmType.LOGGING)
    xi.chocobo.initZone(zone)

    xi.beastmenTreasure.updatePeddlestox(xi.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end

zoneObject.onGameDay = function()
    xi.beastmenTreasure.updatePeddlestox(xi.zone.YHOATOR_JUNGLE, ID.npc.PEDDLESTOX)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(299.997, -5.838, -622.998, 190)
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.chocoboGame.handleMessage(player)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onZoneWeatherChange = function(weather)
    -- Harvesting points only appear during rainy weather
    xi.helm.weatherChange(weather, { xi.weather.RAIN, xi.weather.SQUALL }, ID.npc.HARVESTING)
end

return zoneObject
