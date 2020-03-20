-----------------------------------
--
-- Zone: Monastic Cavern (150)
--
-----------------------------------
local ID = require("scripts/zones/Monastic_Cavern/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.ORCISH_OVERLORD)
    GetMobByID(ID.mob.ORCISH_OVERLORD):setRespawnTime(math.random(900, 10800))

    tpz.treasure.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(261.354, -8.792, 23.124, 175)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
