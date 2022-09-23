-----------------------------------
--
-- Zone: Crawlers_Nest (197)
--
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.DYNAST_BEETLE)
    GetMobByID(ID.mob.DYNAST_BEETLE):setRespawnTime(math.random(5400, 7200))

    xi.treasure.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(380.617, -34.61, 4.581, 59)
    end
    return cs
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
