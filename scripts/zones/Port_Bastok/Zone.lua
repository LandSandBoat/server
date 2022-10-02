-----------------------------------
-- Zone: Port_Bastok (236)
-----------------------------------
local ID = require('scripts/zones/Port_Bastok/IDs')
require('scripts/globals/conquest')
require('scripts/globals/settings')
require('scripts/globals/zone')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -112, -3, -17, -96, 3, -3)     -- event COP
    zone:registerRegion(2, 53.5, 5, -165.3, 66.5, 6, -72) -- drawbridge area
    xi.conquest.toggleRegionalNPCs(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if xi.settings.main.NEW_CHARACTER_CUTSCENE == 1 then
            cs = 1
        end

        player:setPos(132, -8.5, -13, 179)
        player:setHomePoint()
    end

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        if prevZone == xi.zone.BASTOK_JEUNO_AIRSHIP then
            cs = 73
            player:setPos(-36.000, 7.000, -58.000, 194)
        else
            local position = math.random(1, 5) + 57
            player:setPos(position, 8.5, -239, 192)
        end
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onTransportEvent = function(player, transport)
    player:startEvent(71)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif (csid == 71) then
        player:setPos(0, 0, 0, 0, 224)
    end
end

return zone_object
