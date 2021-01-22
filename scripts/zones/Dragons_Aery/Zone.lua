-----------------------------------
--
-- Zone: Dragons_Aery (154)
--
-----------------------------------
local ID = require("scripts/zones/Dragons_Aery/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    if (LandKingSystem_NQ ~= 1) then
        UpdateNMSpawnPoint(ID.mob.FAFNIR)
        GetMobByID(ID.mob.FAFNIR):setRespawnTime(900 + math.random(0, 6) * 1800)
    end
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-60.006, -2.915, -39.501, 202)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
