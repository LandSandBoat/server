-----------------------------------
--
-- Zone: Metalworks (237)
--
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-9.168, 0, 0.001, 128)
    end
    return cs
end

zone_object.afterZoneIn = function(player)
    if player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_BASTOK) then
        player:ChangeMusic(0, 161)   --  Despair
        player:ChangeMusic(1, 161)   --  Despair
    end
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
