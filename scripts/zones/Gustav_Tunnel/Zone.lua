-----------------------------------
--
-- Zone: Gustav Tunnel (212)
--
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/conquest")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.BUNE)
    GetMobByID(ID.mob.BUNE):setRespawnTime(math.random(900, 10800))
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-260.013, -21.802, -276.352, 205)
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
