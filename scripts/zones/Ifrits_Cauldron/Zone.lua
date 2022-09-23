-----------------------------------
--
-- Zone: Ifrits_Cauldron (205)
--
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/helm")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.ASH_DRAGON)
    GetMobByID(ID.mob.ASH_DRAGON):setRespawnTime(math.random(900, 10800))

    xi.treasure.initZone(zone)
    xi.helm.initZone(zone, xi.helm.type.MINING)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-60.296, 48.884, 105.967, 69)
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onGameHour = function(zone)
    -- Opens flame spouts every 3 hours Vana'diel time. Doors are offset from spouts by 5.
    if VanadielHour() % 3 == 0 then
        for i = 5, 8 do
            GetNPCByID(ID.npc.FLAME_SPOUT_OFFSET + i):openDoor(90)
        end
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
