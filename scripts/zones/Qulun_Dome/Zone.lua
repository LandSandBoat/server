-----------------------------------
--
-- Zone: Qulun_Dome (148)
--
-----------------------------------
local ID = require("scripts/zones/Qulun_Dome/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.DIAMOND_QUADAV)
    GetMobByID(ID.mob.DIAMOND_QUADAV):setRespawnTime(math.random(900, 10800))
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(337.901, 38.091, 20.087, 129)
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
