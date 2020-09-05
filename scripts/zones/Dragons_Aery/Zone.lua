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

function onInitialize(zone)
    if (LandKingSystem_NQ ~= 1) then
        UpdateNMSpawnPoint(ID.mob.FAFNIR)
        GetMobByID(ID.mob.FAFNIR):setRespawnTime(900 + math.random(0, 6) * 1800)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-60.006, -2.915, -39.501, 202)
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
