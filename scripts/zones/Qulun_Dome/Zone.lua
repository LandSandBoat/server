-----------------------------------
--
-- Zone: Qulun_Dome (148)
--
-----------------------------------
local ID = require("scripts/zones/Qulun_Dome/IDs")
require("scripts/globals/conquest")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.DIAMOND_QUADAV)
    GetMobByID(ID.mob.DIAMOND_QUADAV):setRespawnTime(math.random(900, 10800))
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(337.901, 38.091, 20.087, 129)
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
