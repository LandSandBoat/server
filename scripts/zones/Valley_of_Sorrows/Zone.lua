-----------------------------------
--
-- Zone: Valley_of_Sorrows (128)
--
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    if (LandKingSystem_NQ ~= 1) then
        UpdateNMSpawnPoint(ID.mob.ADAMANTOISE)
        GetMobByID(ID.mob.ADAMANTOISE):setRespawnTime(900 + math.random(0, 6) * 1800)
    end
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(45.25, -2.115, -140.562, 0)
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
