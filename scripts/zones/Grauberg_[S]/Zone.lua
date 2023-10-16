-----------------------------------
-- Zone: Grauberg_[S] (89)
-----------------------------------
require('scripts/globals/dark_ixion')
-----------------------------------
local ID = zones[xi.zone.GRAUBERG_S]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
    xi.darkixion.zoneOnInit(zone)
end

zoneObject.onGameHour = function(zone)
    xi.darkixion.zoneOnGameHour(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(495.063, 69.903, 924.102, 23)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onZoneWeatherChange = function(weather)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS)

    if npc ~= nil then
        if
            weather == xi.weather.WIND or
            weather == xi.weather.GALES
        then
            npc:setStatus(xi.status.NORMAL)
        else
            npc:setStatus(xi.status.DISAPPEAR)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
