-----------------------------------
--
-- Zone: Ordelles Caves (193)
--
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.MORBOLGER)
    GetMobByID(ID.mob.MORBOLGER):setRespawnTime(math.random(900, 10800))

    tpz.treasure.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-76.839, -1.696, 659.969, 122)
    end
    if prevZone == tpz.zone.LA_THEINE_PLATEAU and player:getCharVar("darkPuppetCS") == 1 then
        cs = 10
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
    if csid == 10 then
        player:setCharVar("darkPuppetCS", 2)
    end
end

return zone_object
