-----------------------------------
--
-- Zone: Bhaflau_Thickets (52)
--
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
require("scripts/globals/chocobo_digging")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.HARVESTMAN)
    GetMobByID(ID.mob.HARVESTMAN):setRespawnTime(math.random(900, 10800))

    tpz.helm.initZone(zone, tpz.helm.type.HARVESTING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-100, -13.5, -479.514, 60)
    end
    if (prevZone == tpz.zone.MAMOOL_JA_TRAINING_GROUNDS) then
        player:setPos(-186, -10, -802, 80)
    end
    return cs
end

zone_object.afterZoneIn = function(player)
    player:entityVisualPacket("1pb1")
    player:entityVisualPacket("2pb1")
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 108) then
        player:setPos(0, 0, 0, 0, 66)
    end
end

return zone_object
