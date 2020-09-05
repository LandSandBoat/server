-----------------------------------
--
-- Zone: The_Shrouded_Maw (10)
--
-----------------------------------
local ID = require("scripts/zones/The_Shrouded_Maw/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-300, -1.5, -220, 62)
    end
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.DARKNESS_NAMED  and  player:getCharVar("PromathiaStatus") == 1) then
        cs =2
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
    if (csid == 2) then
        player:setCharVar("PromathiaStatus", 2)
    end
end
